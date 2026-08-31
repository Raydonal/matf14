# Retomada — MATF14 2026.2 (revisão de slides, livro e página do curso)

**Última atualização:** 2026-08-31, ~20:10 (horário local). Tudo commitado e empurrado para o
`main` (`git@github.com:Raydonal/matf14.git`, HEAD = `8350d52`). Página do curso já está no ar em
<https://raydonal.github.io/matf14/> (o professor ativou o GitHub Pages: Settings → Pages →
Deploy from branch → `main` → `/`). Este arquivo existe para retomar o trabalho sem precisar
reconstruir o contexto do zero.

## Backup

Snapshot completo do projeto (fora do git, seguro para qualquer experimento) em:
`/home/raydonal/Github/Cursos/matf14-backups/matf14_backup_20260831-2010.tar.gz` (35 MB, 533
arquivos, integridade de gzip verificada). Gere um novo antes de qualquer mudança grande futura:

```bash
TS=$(date +%Y%m%d-%H%M)
cd /home/raydonal/Github/Cursos
tar --exclude='matf14/.git' -czf "matf14-backups/matf14_backup_${TS}.tar.gz" matf14
gzip -t "matf14-backups/matf14_backup_${TS}.tar.gz" && echo OK
```

## Estado atual (git — tudo limpo e commitado)

`git status` sem pendências. Working tree = remote = `main` (`8350d52`). Não há branches
divergentes nem stash pendente.

## Estrutura atual — o que existe hoje

1. **`Livro/`** — bookdown, 4 capítulos (mesma numeração da ementa: descritiva, probabilidade, VA
   discretas, VA contínuas) + **3 apêndices**: A) `05-ferramentas-rpython.Rmd` (novo — instalação,
   calculadora, dados, funções, loops, aleatórios, gráficos em R e Python lado a lado), B)
   `06-revisao-calculo.Rmd`, C) `07-formulario.Rmd`. `_bookdown.yml` tem `new_session: no` (mudado
   de `yes` — ver bug #1 abaixo).
2. **`Aulas2026/`** — 31 decks xaringan: `MATF14-01` a `30` (pulando 02 e 16 no cronograma oficial)
   mais `MATF14-02` como **material extra sem data** (mesmo conteúdo do Apêndice A, em slides).
   Todos revisados nesta sessão quanto a clareza (provocações com gráfico/dado real em vez de só
   texto) e quanto aos bugs #2/#3 abaixo.
3. **`Listas2026/`** — 14 listas em LaTeX, sem gabarito neste repositório (nem nunca deve ter,
   `.gitignore` bloqueia `Gabarito*`).
4. **`index.Rmd`/`index.html`** — página do curso na raiz, no padrão do curso irmão
   [matd48](https://github.com/Raydonal/matd48): plano de ensino, critério de aprovação
   (NF = (P1+P2+P3)/3), cronograma completo linkando aula/capítulo do livro/lista.
5. **`CLAUDE.md`** — atualizado com a estrutura de apêndices e o aviso sobre `new_session`/marcador
   `(APPENDIX)` único (bug #1).

## Bugs sérios encontrados e corrigidos nesta sessão

Documentados aqui porque não são óbvios e podem voltar se alguém mexer nesses arquivos sem saber
da causa. Todos achados com verificação **visual/funcional real** (headless Chrome via pacote R
`chromote`, instalado nesta sessão), não só "renderizou sem erro" (exit code) — essa é a lição
principal: sempre abrir o HTML gerado e checar, nunca confiar só no render ter terminado sem erro.

1. **Imagens de `ggplot`/base R quebradas no livro** (21 imagens em 12 páginas). Causa:
   `_bookdown.yml` tinha `new_session: yes`, que knita cada capítulo isolado; o `<img src>` gerado
   apontava para `NN-capitulo_files/figure-html/...`, mas o arquivo real ficava um nível abaixo, em
   `_bookdown_files/NN-capitulo_files/figure-html/...`. **Fix:** `new_session: no` em
   `_bookdown.yml` — depois disso os caminhos ficam consistentes (prefixo `livro-matf14_files/`) e
   não precisa de nenhum passo manual de cópia. Se algum dia voltar a `new_session: yes` por algum
   motivo, o sintoma vai reaparecer.

2. **Subscritos (`_`) sumindo de fórmulas nos slides** (20 decks, ~140 ocorrências). Causa: o
   motor de slides (`xaringan`/`remark.js`) faz sua própria leitura de markdown *antes* do MathJax
   processar qualquer coisa — não sabe que `$$...$$`/`\(...\)` marcam matemática, então pares de
   `_` dentro de uma fórmula longa (ex.: "cases" de média/mediana, somatórios com dois ou mais
   subscritos) são lidos como abre/fecha itálico e desaparecem. **Fix:** escapar como `\_` dentro
   de blocos de matemática nos `.Rmd` de `Aulas2026/` — o parser do remark.js trata `\_` como
   escape (produz `_` literal sem virar ênfase) e o MathJax lê esse `_` normalmente como subscrito.
   **Isso só se aplica a `Aulas2026/` (xaringan)**, não a `Livro/` (bookdown/pandoc processa math
   corretamente sem escape).

3. **Comparações `<` e `>` sumindo de fórmulas nos slides** (12 decks, ~20 ocorrências). Mesma
   causa raiz do bug #2: o remark.js lê `<...>` como possível abertura de tag HTML e apaga tudo
   entre o primeiro `<` e o próximo `>`, mesmo dentro de `$$`. Escapar com barra (`\<`) **não
   funciona** nesse parser (ele tenta casar a tag antes de processar o escape). **Fix:** usar as
   entidades HTML `&lt;`/`&gt;` em vez do caractere literal — o remark.js não reconhece isso como
   abertura de tag (não há `<` de verdade na fonte), e o navegador decodifica a entidade para
   `<`/`>` só depois, quando o MathJax já está lendo o texto final. Mesma ressalva: só
   `Aulas2026/`, não `Livro/`.

4. **Overflow de conteúdo nos slides** (14 slides em 9 decks: 02, 03, 06, 08, 19, 21, 25, 27, 28).
   Slides acumulando texto+gráfico+tabela demais num só (via `--` de reveal progressivo) ficavam
   maiores que os 681px de área visível do slide. **Fix:** dividido em mais slides (trocando `--`
   por `---` nos pontos certos) ou, quando a imagem sozinha já estourava, reduzido
   `out.width`/`out.height`. Sem verificação visual isso é invisível no `rmarkdown::render()` —
   ele não falha, só corta o que não cabe.

5. **Equações genuinamente erradas** (não um bug de parser, erro de digitação): 3 casos em
   MATF14-06/18/23 onde alguém quis escrever "R$ X" mas digitou `R\(`/`R\)` (delimitadores de
   matemática do remark.js), fazendo o MathJax tentar renderizar um pedaço da frase como fórmula.
   Mais 16 casos de `R\$` (escape de Pandoc que não existe no parser client-side do remark.js — só
   deixava um `\` literal visível colado no valor). Ambos corrigidos para texto simples "R$ X".

6. **Tabela do cronograma cortada em celular** na página do curso — a tabela larga (4 colunas)
   ultrapassava a tela em telas estreitas. **Fix:** `kableExtra::scroll_box(width = "100%")` — a
   tabela agora rola dentro de si mesma em vez de quebrar o layout da página.

## O que falta — pendente, e é decisão do professor

- **Repositório privado**: expliquei ao professor que dá para tornar o repo privado e ainda manter
  a página do GitHub Pages pública (funciona no plano gratuito: Settings → General → Danger Zone →
  Change visibility → Private, sem precisar mexer no Pages). Ele ainda não decidiu.
- **Contato/e-mail público** na página do curso: usei `raydonalmartinez@ufba.br` (o mesmo já
  público na página do matd48), e o texto de "Atenção aos estudantes" (atendimento por
  agendamento) também foi copiado do matd48 — nunca confirmado explicitamente pelo professor que é
  isso mesmo que ele quer para esta turma.
- **Nenhuma leitura humana ponta-a-ponta** aconteceu ainda depois de todas essas rodadas — as
  verificações desta sessão foram automatizadas (headless Chrome: overflow, imagem ausente, math
  não renderizado, scroll horizontal) mais leitura pontual de cada trecho alterado, não uma leitura
  corrida de todo o livro/todos os 31 decks pelo professor.

## Como retomar

1. Ler o feedback específico do professor sobre o que revisar/ajustar.
2. Se for correção pontual: editar o(s) arquivo(s), re-renderizar (comandos abaixo), **conferir
   abrindo o HTML gerado num navegador de verdade ou com o script de checagem** — nunca só
   confiar no render ter terminado sem erro (foi assim que os bugs 1-6 acima escaparam de rodadas
   anteriores).
3. Só commitar/pushar quando o professor confirmar que está satisfeito (nesta sessão o professor
   pediu push a cada rodada de correção, mas confirme antes de assumir isso como padrão permanente).

### Comandos de verificação rápida

```bash
# Livro (bookdown) — um comando só, new_session:no já cuida de tudo
cd Livro
Rscript -e 'bookdown::render_book("index.Rmd", quiet = TRUE)'

# checagem de imagem ausente/vazia (Livro/ e Aulas2026/)
cd ..
python3 -c "
import re, os, glob
def check(html_dir):
    problems = 0
    for f in sorted(glob.glob(os.path.join(html_dir, '*.html'))):
        txt = open(f, encoding='utf-8', errors='replace').read()
        for src in set(re.findall(r'src=\\\\?\"([^\"\\\\]+)\\\\?\"', txt)):
            if src.startswith('http') or src.startswith('data:'): continue
            p = os.path.normpath(os.path.join(html_dir, src))
            if not os.path.exists(p) or os.path.getsize(p) == 0:
                print('PROBLEMA:', f, '->', src); problems += 1
    print(html_dir, ':', problems, 'problemas')
check('Aulas2026'); check('Livro')
"

# Aulas2026 (xaringan) — renderizar um deck
cd Aulas2026 && Rscript -e "rmarkdown::render('MATF14-NN.Rmd', quiet = TRUE)"
```

Para checagem visual real (overflow de slide, math não renderizado, scroll horizontal), é preciso
`chromote` (`install.packages("chromote")`, já instalado no ambiente desta sessão) — os scripts
usados ficaram só no scratchpad temporário da sessão (não versionados), mas a lógica está descrita
nos bugs #1-4 acima e pode ser reconstruída rapidamente: abrir o HTML com `chromote`, esperar o
MathJax/remark.js rodarem (~3-4s), e checar `document.querySelectorAll(".remark-slide-content")`
(overflow: `scrollHeight` de cada slide contra os ~681px do `.remark-slide-scaler`; math não
renderizado: `textContent` ainda contendo `$$` ou `\(`/`\)` cru após o MathJax processar).
