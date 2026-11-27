# ChemMaster

Aplicação Android-first de aprendizagem de Química. O primeiro mercado é Moçambique; a estrutura de conteúdos foi organizada para permitir acrescentar outros currículos e idiomas no futuro.

## Implementado nesta fase

- Interface Flutter em português, com tema escuro/claro.
- Navegação Início, Academia, Ferramentas, Progresso e Mais.
- Conteúdos curriculares iniciais para 7.ª a 12.ª classes, organizados por ciclos, classes, unidades e lições expansíveis.
- Lições com resumo, explicação, exemplo e opção para marcar como concluída.
- Tabela periódica com 118 elementos, pesquisa por nome, símbolo ou número atómico.
- Parser de fórmulas tolerante a minúsculas, espaços e índices Unicode, com grupos entre parênteses.
- Descoberta offline de produtos para reacções escolares conhecidas, com equação balanceada, tipo de reacção e explicação passo a passo.
- Exemplos de neutralização, síntese, combustão, precipitação, reacções de ácidos com carbonatos e saponificação (sabão).
- Calculadora de estrutura atómica: Z, A, número de neutrões, protões e electrões, com selecção do isótopo.
- Distribuição electrónica por subníveis e camadas para os 118 elementos, com indicação de resultados aproximados em elementos pesados.
- Testes automatizados para fórmulas com escrita flexível, balanceamento, descoberta de produtos e distribuição electrónica.
- Balanceador de equações por eliminação de Gauss com aritmética racional, com testes de reacções comuns.
- Calculadoras: massa molar, quantidade de matéria, concentração molar, densidade, percentagem em massa e diluição.
- Referência de reacções químicas e nomenclatura de óxidos, ácidos, bases e sais.
- Questionário de escolha múltipla com correcção, explicação e pontuação.
- Progresso local (lições, respostas e melhores pontuações) através de SharedPreferences.
- Workflow GitHub Actions para análise, testes e compilação APK Android.

## Base curricular

A organização curricular segue os documentos do INDE/MEC para o Ensino Secundário, 1.º Ciclo (7.ª, 8.ª e 9.ª classes) e 2.º Ciclo (10.ª, 11.ª e 12.ª classes). Os conteúdos estão distribuídos pelas unidades temáticas indicadas nos respectivos programas.

Fontes consultadas:\n- 1.º Ciclo: https://ieda.gov.mz/site/wp-content/uploads/2020/10/ANEXO_X_PROGRAMA_QUIMICA_ES_I_CICLO_GM_11_02_26_assinado.pdf\n- 2.º Ciclo: https://ieda.gov.mz/site/wp-content/uploads/2020/10/ANEXO_X_PROGRAMA_QUIMICA_ES_II_CICLO_GM_11_02_26_assinado.pdf

A estrutura cobre as seis classes do ensino secundário. As lições são resumos didácticos iniciais dos tópicos dos programas; não constituem ainda cobertura integral de cada objectivo, trimestre ou carga horária. Devem ser revistas por professores antes de uma publicação escolar formal. Os textos explicativos e exemplos incluídos na app são materiais didácticos redigidos para apoiar os tópicos curriculares, não transcrições integrais do documento oficial.

## Limitações científicas a validar antes de publicação

- O balanceador é um motor algébrico geral para equações moleculares simples; não é ainda um solucionador especializado de reacções iónicas, redox em meio ácido/básico ou equações com electrões e cargas explícitas.
- O parser reconhece elementos, minúsculas, espaços, índices Unicode e parênteses; fórmulas com hidratos, cargas iónicas e notação isotópica ainda não são suportadas.
- A descoberta de produtos usa uma base offline de reacções conhecidas. Não prevê qualquer combinação arbitrária de elementos: condições como temperatura, concentração, solvente, pressão e catalisador podem alterar os produtos.
- A saponificação é apresentada como equação geral, porque os óleos e gorduras contêm misturas variáveis de triglicéridos. A explicação é teórica; não é uma receita laboratorial.
- O número de neutrões depende do isótopo escolhido (A); a massa atómica média da tabela periódica não substitui o número de massa de um isótopo específico.
- A distribuição electrónica usa a regra de preenchimento e excepções comuns; para alguns elementos pesados, o resultado é assinalado como aproximado e deve ser confirmado em fontes especializadas.
- Massas de elementos radioactivos sem isótopos estáveis são valores de número de massa de isótopos representativos, não pesos atómicos padrão.
- O banco de exercícios é inicial e necessita de revisão por professores de Química moçambicanos e ampliação por unidade.
- O progresso fica guardado no dispositivo; não existe sincronização de conta/nuvem nesta versão.

## Desenvolvimento

Requer Flutter stable e Dart compatível com o SDK definido em `pubspec.yaml`.

```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

O workflow Android executa estes passos automaticamente em cada push para `main` e publica o APK como artefacto da execução quando a compilação passa.
