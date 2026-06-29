param([string]$Token)

$ErrorActionPreference = "Stop"

$WikiPages = @{
    "Home"             = "# Welcome to the MinusFrameWork Wiki`n`nMinusFrameWork is a modern Delphi framework for building enterprise applications.`n`n## Modules`n`n- **[Core](Core)** - Base framework (attributes, config, connection pool, exceptions)`n- **[ORM](ORM)** - Object-Relational Mapping with FireDAC`n- **[Migrator](Migrator)** - Database migration management`n- **[Messaging](Messaging)** - Async messaging and event bus`n- **[Telemetry](Telemetry)** - Application monitoring and metrics`n- **[FeatureFlags](FeatureFlags)** - Feature flag management`n- **[Extensions](Extensions)** - Additional utilities and helpers`n- **[AI](AI)** - MCP Server for AI-assisted development`n- **[CLI](CLI)** - Command-line scaffolding tool`n`n## Quick Links`n`n- [Getting Started](Getting-Started)`n- [Architecture Overview](Architecture)`n- [Contributing](Contributing)`n- [License](https://github.com/GabrielFerreiraMendes/minusframework-meta/blob/main/LICENSE)"
    "_Sidebar"         = "- [Home](Home)`n- [Getting Started](Getting-Started)`n- **Modules**`n  - [Core](Core)`n  - [ORM](ORM)`n  - [Migrator](Migrator)`n  - [Messaging](Messaging)`n  - [Telemetry](Telemetry)`n  - [FeatureFlags](FeatureFlags)`n  - [Extensions](Extensions)`n  - [AI](AI)`n  - [CLI](CLI)`n- [Architecture](Architecture)`n- [Contributing](Contributing)"
    "_Footer"          = "**MinusFrameWork** - [Repository](https://github.com/GabrielFerreiraMendes/minusframework-meta)"
    "Getting-Started"  = "# Getting Started`n`n## Prerequisites`n`n- Delphi 11 or later`n- FireDAC (included with Delphi)`n- Git with LFS support`n`n## Installation`n`nClone the meta-repository and initialize all submodules:`n`n````powershell`ngit clone https://github.com/GabrielFerreiraMendes/minusframework-meta.git`ncd minusframework-meta`ngit submodule update --init --recursive`n````"
    "Core"             = "# Core Module`n`nBase framework providing foundational components: MF.Attributes, MF.Config, MF.Connection, MF.ConnectionPool, MF.Exceptions, MF.Provider, MF.Mapper, MF.MetadataCache, MF.QueryBuilder, MF.RepositoryBase, MF.SelectBuilder, MF.UnitOfWork, MF.CommandExecutor."
    "ORM"              = "# ORM Module`n`nObject-Relational Mapping with FireDAC. Features attribute-based mapping, generic repository, CRUD operations, automatic SQL generation."
    "Migrator"         = "# Migrator Module`n`nDatabase migration management with versioned migrations, rollback support, CLI interface."
    "Messaging"        = "# Messaging Module`n`nAsync messaging and event bus for Delphi applications with pub/sub, multiple transport backends."
    "Telemetry"        = "# Telemetry Module`n`nApplication monitoring and metrics collection: performance metrics, error tracking, custom metrics."
    "FeatureFlags"     = "# FeatureFlags Module`n`nFeature flag management for toggling functionality. Supports boolean/percentage flags, multi-provider, audit logging, license tiers (Free/Pro/Enterprise)."
    "Extensions"       = "# Extensions Module`n`nAdditional utilities and helpers: extended data types, helper functions, utility classes."
    "AI"               = "# AI Module`n`nMCP Server for AI-assisted development with FireDAC database integration. Tools: executar_consulta, gerar_entidade, listar_tabelas, explicar_codigo, criar_migracao."
    "CLI"              = "# CLI Module`n`nCommand-line scaffolding tool. Commands: make:entity, new:api, new:module."
    "Architecture"     = "# Architecture Overview`n`nMeta-repository with 9 submodules: Core, ORM, Migrator, Messaging, Telemetry, FeatureFlags, Extensions, AI, CLI."
    "Contributing"     = "# Contributing`n`nClone with submodules, follow Conventional Commits (feat:, fix:, docs:, refactor:, test:, chore:), submit PRs from feature branches."
}

$tmpDir = Join-Path $env:TEMP "minusframework-wiki-deploy"
if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
New-Item -ItemType Directory -Path $tmpDir -Force | Out-Null

Set-Location $tmpDir
git init
git checkout -b main

foreach ($page in $WikiPages.Keys) {
    Set-Content -Path "$page.md" -Value $WikiPages[$page] -NoNewline
}

git add -A
git commit -m "docs: initial wiki setup"

if ($Token) {
    $repoUrl = "https://GabrielFerreiraMendes:${Token}@github.com/GabrielFerreiraMendes/minusframework-meta.wiki.git"
} else {
    $repoUrl = "https://github.com/GabrielFerreiraMendes/minusframework-meta.wiki.git"
}

git remote add origin $repoUrl
git push -u origin main

Remove-Item $tmpDir -Recurse -Force
Set-Location $PSScriptRoot

Write-Host "Wiki deployed!" -ForegroundColor Green