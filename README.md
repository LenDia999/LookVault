# LookVault

## Deploy no Vercel

O projeto usa o runtime **Container** do Vercel. O `Dockerfile` na raiz do
repositório instala o PHP com `mysqli` e publica a aplicação localizada em
`LOOKVAULT/LOOKVAULT`.

Nas configurações do projeto Vercel:

1. Deixe o **Root Directory** como a raiz do repositório.
2. Selecione **Container** como Framework Preset, caso o Vercel não detecte o
   Dockerfile automaticamente.
3. Configure estas variáveis no ambiente Production (e também em Preview, se
   for usar):

   | Variável | Descrição |
   | --- | --- |
   | `DB_HOST` | Host público do banco MySQL |
   | `DB_PORT` | Porta do banco, normalmente `3306` |
   | `DB_NAME` | Nome do banco de dados |
   | `DB_USER` | Usuário do banco |
   | `DB_PASSWORD` | Senha do banco |

   O usuário e o host do banco também precisam permitir conexões a partir do
   Vercel. Não coloque credenciais no código nem as envie ao Git.

4. Crie um **Vercel Blob Store** com acesso público e conecte-o ao projeto,
   habilitando a variável `BLOB_READ_WRITE_TOKEN` em Production (e Preview, se
   necessário).
5. Execute uma vez no banco de produção o script
   `LOOKVAULT/LOOKVAULT/database/vercel_sessions.sql`. Ele cria a tabela usada
   para manter os logins entre instâncias.

O projeto também aceita os nomes antigos `LOOKVAULT_DB_HOST`,
`LOOKVAULT_DB_PORT`, `LOOKVAULT_DB_NAME`, `LOOKVAULT_DB_USER` e
`LOOKVAULT_DB_PASS`.

## Executar localmente com Docker

Com Docker Desktop e o MySQL local em execução:

```powershell
docker build -t lookvault .
docker run --rm -p 8080:80 `
  -e DB_HOST=host.docker.internal `
  -e DB_PORT=3306 `
  -e DB_NAME=lookvault `
  -e DB_USER=root `
  -e DB_PASSWORD= `
  lookvault
```

Abra `http://localhost:8080`. Importe primeiro
`LOOKVAULT/LOOKVAULT/database/lookvault_corrigido.sql` no MySQL. Para executar
sem Docker, continue usando o servidor PHP local e as configurações padrão
(`localhost`, `root`, porta `3306`, banco `lookvault`).

## Arquivos enviados pelos usuários

O Vercel não oferece armazenamento persistente no disco do container. Por isso,
no Vercel as fotos de peças e de perfil são enviadas ao Vercel Blob; localmente,
continuam sendo salvas em `uploads/`. As sessões no Vercel são armazenadas no
MySQL pela tabela `php_sessions`; localmente, fora do Docker, o PHP mantém o
comportamento padrão de sessões em arquivo.