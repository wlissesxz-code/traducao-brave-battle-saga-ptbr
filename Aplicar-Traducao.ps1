param([string]$Pasta, [switch]$Verificar, [switch]$Restaurar)
$ErrorActionPreference = 'Stop'
$original = '3b89962935aadc8ae1b7db5b2556b38c8eff6035920f4bcb2f065d86da92d0ee'
$traduzido = '33b1c8610a95e2d161dc2ce28fcaf786494ad09e2e22e93b8704755ad92d82f0'
function HashBytes([byte[]]$bytes) {
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return ([BitConverter]::ToString($sha.ComputeHash($bytes))).Replace('-', '').ToLowerInvariant() }
    finally { $sha.Dispose() }
}
try {
    if (!$Pasta) { $Pasta = (Read-Host 'Cole a pasta do jogo (que contem a subpasta res)').Trim().Trim('"') }
    $Pasta = (Resolve-Path -LiteralPath $Pasta).Path
    $alvo = Join-Path $Pasta 'res\game'
    $backup = Join-Path $Pasta 'res\game.original-ptbr.bak'
    $bytes = [IO.File]::ReadAllBytes($alvo)
    $hash = HashBytes $bytes
    if ($Restaurar) {
        if ($hash -eq $original) { Write-Host 'O jogo ja esta no original.'; exit 0 }
        if ($hash -ne $traduzido) { throw 'Arquivo atual desconhecido. Restauracao cancelada.' }
        $resultado = [IO.File]::ReadAllBytes($backup)
        if ((HashBytes $resultado) -ne $original) { throw 'Backup original invalido.' }
    } else {
        if ($hash -eq $traduzido) { Write-Host 'A traducao beta 1.2 ja esta instalada.'; exit 0 }
        if ($hash -ne $original) { throw "Versao incompativel. Nenhum arquivo alterado. SHA256: $hash" }
        $ips = [IO.File]::ReadAllBytes((Join-Path $PSScriptRoot 'Brave-Battle-Saga-PTBR.ips'))
        if ([Text.Encoding]::ASCII.GetString($ips,0,5) -ne 'PATCH') { throw 'Patch invalido.' }
        $resultado = New-Object byte[] 4194304
        for ($k=0; $k -lt $resultado.Length; $k++) { $resultado[$k]=255 }
        [Array]::Copy($bytes, $resultado, $bytes.Length)
        $i=5
        while ($true) {
            if ($i+3 -gt $ips.Length) { throw 'Patch truncado.' }
            if ([Text.Encoding]::ASCII.GetString($ips,$i,3) -eq 'EOF') { $i+=3; break }
            if ($i+5 -gt $ips.Length) { throw 'Patch truncado.' }
            $dest=[int]$ips[$i]*65536+[int]$ips[$i+1]*256+[int]$ips[$i+2]
            $n=[int]$ips[$i+3]*256+[int]$ips[$i+4]; $i+=5
            if ($n -eq 0) {
                if ($i+3 -gt $ips.Length) { throw 'Patch RLE truncado.' }
                $n=[int]$ips[$i]*256+[int]$ips[$i+1]; $v=$ips[$i+2]; $i+=3
                if ($dest+$n -gt $resultado.Length) { throw 'Patch fora dos limites.' }
                for ($k=0; $k -lt $n; $k++) { $resultado[$dest+$k]=$v }
            } else {
                if ($i+$n -gt $ips.Length -or $dest+$n -gt $resultado.Length) { throw 'Patch fora dos limites.' }
                [Array]::Copy($ips,$i,$resultado,$dest,$n); $i+=$n
            }
        }
        if ($i+3 -ne $ips.Length -or ($ips[$i]*65536+$ips[$i+1]*256+$ips[$i+2]) -ne $resultado.Length) { throw 'Tamanho final invalido.' }
        if ((HashBytes $resultado) -ne $traduzido) { throw 'Falha na verificacao da traducao. Nada alterado.' }
    }
    if ($Verificar) { Write-Host 'Verificacao concluida. Nenhum arquivo alterado.'; exit 0 }
    if (Test-Path -LiteralPath $backup) {
        if ((HashBytes ([IO.File]::ReadAllBytes($backup))) -ne $original) { throw 'Ja existe um backup diferente. Nada alterado.' }
    } elseif (!$Restaurar) { [IO.File]::WriteAllBytes($backup,$bytes) }
    $temp = Join-Path (Split-Path $alvo) ('game.ptbr-'+[guid]::NewGuid().ToString('N')+'.tmp')
    try {
        [IO.File]::WriteAllBytes($temp,$resultado)
        # Detect a changed source before the atomic replacement.
        if ((HashBytes ([IO.File]::ReadAllBytes($alvo))) -ne $hash) { throw 'O arquivo mudou durante a operacao. Tente com o jogo fechado.' }
        [IO.File]::Replace($temp,$alvo,[System.Management.Automation.Language.NullString]::Value)
    } finally { if ($temp -and (Test-Path -LiteralPath $temp)) { Remove-Item -LiteralPath $temp } }
    Write-Host 'Concluido. Seus salvamentos e configuracoes nao foram alterados.'
    exit 0
} catch {
    Write-Host ('ERRO: '+$_.Exception.Message) -ForegroundColor Red
    Write-Host 'Feche o jogo e confira a pasta. Em pastas protegidas, use uma copia em uma pasta com permissao de escrita.'
    exit 1
}
