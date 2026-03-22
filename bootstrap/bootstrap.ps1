New-Item -ItemType Directory -Force -Path .agent-config, .claude, .claude/commands | Out-Null
Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/yzhao062/agent-config/main/AGENTS.md -OutFile .agent-config/AGENTS.md
Copy-Item .agent-config/AGENTS.md AGENTS.md -Force
if (Test-Path .agent-config/repo/.git) {
  git -C .agent-config/repo pull --ff-only
} else {
  git clone --depth 1 --filter=blob:none --sparse https://github.com/yzhao062/agent-config.git .agent-config/repo
}
git -C .agent-config/repo sparse-checkout set skills .claude
if (Test-Path .agent-config/repo/.claude/commands) {
  Copy-Item .agent-config/repo/.claude/commands/*.md .claude/commands/ -Force
}
if (Test-Path .agent-config/repo/.claude/settings.json) {
  if (Test-Path .claude/settings.json) {
    $shared = Get-Content .agent-config/repo/.claude/settings.json -Raw | ConvertFrom-Json
    $project = Get-Content .claude/settings.json -Raw | ConvertFrom-Json
    foreach ($prop in $shared.PSObject.Properties) {
      $project | Add-Member -NotePropertyName $prop.Name -NotePropertyValue $prop.Value -Force
    }
    $project | ConvertTo-Json -Depth 10 | Set-Content .claude/settings.json
  } else {
    Copy-Item .agent-config/repo/.claude/settings.json .claude/settings.json -Force
  }
}
if (-not (Test-Path .gitignore) -or -not (Select-String -Quiet -Pattern '^\.agent-config/' .gitignore)) {
  Add-Content -Path .gitignore -Value "`n.agent-config/"
}
