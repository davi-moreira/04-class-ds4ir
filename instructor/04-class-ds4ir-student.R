# ---
#   title: "DS4IR"
# subtitle: "Visualização de dados I: Gráficos"
# author: 
#   - Professor Davi Moreira
# - Professor Rafael Magalhães
# date: "`r format(Sys.time(), '%d-%m-%Y')`"
# output: 
#   revealjs::revealjs_presentation:
#   theme: simple
# highlight: haddock
# transition: slide
# center: true
# css: stylesheet.css
# reveal_options:
#   controls: false  # Desativar botões de navegação no slide
# mouseWheel: true # Passar slides com o mous e
# ---
#   
#   ## Programa
#   - Introdução ao `ggplot()`
# - Indo além do básico
# - A gramática dos gráficos
# - Temas
# - Estatísticas calculadas
# - Posicionamento dos elementos
# - Definição de coordenadas
# 
# 
# ## Introdução ao `ggplot()`
# 
# O `gg` em `ggplot()` se refere a [Grammar of Graphics](http://vita.had.co.nz/papers/layered-grammar.pdf). 
# Mais do que um pacote gráfico, o `ggplot()` é um conjunto de princípios sobre visualização de dados e contrução 
# de gráficos.
# 
# ```{r results='hide'}
library(ggplot2)
library(tidyverse)
# ```
# 
# ## Primeiros passos
# Vamos usar uma base de dados sobre características de carros para ilustrar o passo-a-passo da montagem de um gráfico. 
# Depois, aplicamos os mesmos princípios a uma base que seja mais interessante. 
# 
# ```{r eval=FALSE, message=FALSE, warning=FALSE, results='hide'}
head(mpg)
# ```
# 
# Vamos verificar associação entre o tamanho do motor de um carro (`displ`) e a eficiência 
# do uso de combustível (`hwy`).
# 
# Para fazer o gráfico, basta indicar para o ggplot qual é a base de dados (`data`), 
# qual é o tipo de função (`geom_point`) e quais são as variáveis dos eixos x e y (`mapping`).
# 
# ```{r message=FALSE, warning=FALSE, results='hide'}
mpg %>% ggplot() + # gráfico-base
  geom_point(mapping = aes(x = displ, y = hwy)) # insere uma camada de pontos
# ```
# 
# ## Gramática dos gráficos
# Vejam que a lógica da construção dos gráficos foi a de criar um gráfico-base com a 
# função `ggplot()`, e depois incluir uma camada com os elementos gráficos. 
# 
# **A lógica é sempre essa**: criar uma figura simples e adicionar, sucessivamente, camadas com as 
# informações que queremos. 
# 
# O gráfico que fizemos é bastante simples, e tem apenas 3 passos:
#   
#   1. Definição da base de dados a ser usada (`data = mpg`)
# 2. Definição do tipo de gráfico a ser usado (`geom_point`)
# 3. Definição do *mapeamento* das informações no gráfico (`mapping = aes(x = displ, y = hwy)`)
# 
# Para fazer gráficos mais sofisticados, podemos colocar mais informações nas camadas existentes ou 
# adicionar mais camadas. Antes de ir além, é sua vez de fazer um gráfico.
# 
# ## Exercício
# 
# Escolha outra variável qualquer na base `mpg` e desenvolva gráfico similar ao que vimos.

## Exercício: resposta


# ## Indo além do básico
# 
# ## A gramática dos gráficos
# Acabamos de passar por todos os elementos de uma sintaxe completa de visualização de informação. 
# Vamos revisar os fundamentos dessa gramática:
# 
# 1. Definição dos dados a serem utilizados: `data`
# 2. Definição do tipo de elemento gráfico: `geom`
# 3. *Link* dos dados e dos elementos gráficos: `mapping`
# 4. Definição da estatística a ser exibida: `stat`
# 5. Posicionamento dos elementos gráficos: `position`
# 6. Definição das coordenadas: `coord`
# 7. Separação gráfica entre diferentes elementos: `facet`
# 
# Dominar esses fundamentos dá uma liberdade enorme para visualizar qualquer tipo de informação! 
#   Vamos para um exemplo mais complexo.
# 
# ## Incluindo mais informações em uma camada
# A base de dados `mpg` tem uma variável (`class`) com o tipo de carro: "compacto", "SUV", etc. 
# Podemos incluir essa informação, colorindo cada classe.
# 
# ```{r fig.height = 3.5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# ```
# 
# ## Cuidado com o que vai dentro e fora dos parênteses
# Se você quiser pintar todos os pontos de verde, independentemente do tipo de carro, 
# o código vai ter uma diferença que, a princípio, parece sutil.
# 
# ```{r fig.height = 3.5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "darkgreen")
# ```
# 
# ## Cuidado com o que vai dentro e fora dos parênteses
# Veja a diferença! O que aconteceu?
#   
#   ```{r fig.height = 3.5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "darkgreen"))
# ```
# 
# ## Incluindo mais uma camada
# Pode ser que, mesmo dando uma cor pra cada categoria de carro, você tenha achado que 
# a diferença não ficou tão clara. Uma opção é colocar cada categoria em sua própria 
# escala, oque podemos fazer com a função `facet_wrap()`
# 
# ```{r fig.height = 3.5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 1)
# ```
# 
# ## Mais de uma informação em um mesmo gráfico
# A inclusão de nova camadas também serve para colocar elementos diferentes no gráfico. 
# Se quisermos traçar uma curva de ajuste no gráfico original, basta adicionar o 
# elemento `geom_smooth()`
# 
# ```{r fig.align="center", fig.height=3.0, message=FALSE, warning=FALSE}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy), se = FALSE)
# ```
# 
# ## Temas
# 
# ## Temas
# Para além dos elementos estruturais que vimos, uma boa apresentação de dados depende 
# também de ajustes estéticos. Vamos cobrir brevemente algumas possibilidades.
# 
# O `ggplot` já vem com alguns temas pré-definidos. Você não é obrigado a gostar daquele 
# fundo cinza: vamos reproduzir o gráfico da relação entre tamanho e eficiência do motor dos carros, 
# com os temas `theme_bw`, `theme_light`, `theme_dark`, `theme_minimal` e `theme_classic`.
# 
# ## Gráfico original
# ```{r fig.height = 5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy))
# ```
# 
# ## Preto e branco
# ```{r fig.height = 5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  theme_bw()
# ```
# 
# ## Light
# ```{r fig.height = 5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  theme_light()
# ```
# 
# ## Dark
# ```{r fig.height = 5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  theme_dark()
# ```
# 
# ## Mínimo
# ```{r fig.height = 5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  theme_minimal()
# ```
# 
# ## Clássico
# ```{r fig.height = 5, fig.align="center"}
mpg %>% ggplot() + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  theme_classic()
# ```
# 
# ## Outros temas?
# Para quem não gostou desses temas, há duas opções:
#   
#   - Você pode alterar **absolutamente tudo** no gráfico com a função `theme()`, 
# elemento por elemento. Para isso você precisa ter um bom olho para design gráfico, 
# além de paciência para mexer em cada detalhe. Veja o número de argumentos que podem 
# ser alterados com o comando `?theme` 
# 
# - Instalar pacotes externos com temas prontos. Dois dos quais gosto muito são o [ggthemes](https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/) e 
# o [hrbrthemes](https://github.com/hrbrmstr/hrbrthemes)
# 
# No Google você ainda consegue achar muitos outros pacotes.
# 
# ## Estatísticas calculadas
# 
# ## Tipos de gráfico
# Todos os exemplos acima foram feitos com gráficos de dispersão. O `ggplot` suporta 
# vários outros tipos de gráfico: barras, áreas, linhas, pizza (ugh!), etc.
# 
# **O importante é que a lógica é a mesma!** O que muda é o tipo de estatística relevante
# para cada gráfico. No gráfico de dispersão nós usamos os valores das observações 
# na nossa base, mas para outros gráficos precisamos de outras estatísticas: contagem 
# para gráficos de barras, valores preditos para curvas de ajuste, medidas de dispersão 
# para *boxplots*, etc.
# 
# Vamos carregar uma nova base de dados para ilustrar esse ponto, e brincar um pouco com gráficos de barras.
# 
# ```{r message=FALSE, warning=FALSE, results='hide'}
?diamonds
# ```
# 
# ## Gráfico de barras simples
# O código para um gráfico de barras segue o mesmo raciocínio dos gráficos anteriores, 
# e você perceberá que a única coisa que precisamos mudar é o tipo de função usada para 
# mapear os dados: em vez de `geom_point()`, usamos `geom_bar()`. 
# 
# ```{r fig.height = 3.5, fig.align="center"}
diamonds %>% ggplot() + 
  geom_bar(mapping = aes(x = cut))
# ```
# 
# ## Cálculo de estatísticas
# Diferentemente do gráfico de dispersão, não precisamos indicar em nenhum lugar a 
# variável que contém o número de diamantes para cada tipo de corte (até porque essa 
#                                                                    variável não existe no banco de dados!).
# 
# O `ggplot()` reconhece que, quando usamos `geom_bar()`, a estatística relevante é 
# a **contagem** dentro de cada categoria, e faz esse cálculo automaticamente. Outras 
# funções calculam outras estatísticas por padrão (você pode consultar, em `?geom_bar`, 
#                                                  o argumento `stat`).
# 
# <center>
#   ![Transformação estatística](images/visualization-stat-bar.png){width=700px}
# </center>
#   
#   ## Exercício
#   
#   Selecione outra variável na base `diamonds` para produzir novo gráfico de barras.
# 
## Exercício: resposta


#   ## Cálculo de estatísticas
#   Todo gráfico tem uma estatística padrão, mas podemos fazer alterações para relacionar 
# duas variáveis diferentes, por exemplo:
#   
#   ```{r fig.height = 2.5, fig.align="center"}
# relação entre o tipo de corte e as dimensões do diamante
diamonds %>% ggplot() + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
# ```
# 
# 
# ## Posicionamento dos elementos
# 
# ## Alterando as cores das barras
# Similarmente ao gráfico de pontos, podemos alterar a cor das barras com o argumento `fill`
# 
# ```{r fig.height = 4, fig.align="center"}
# relação entre o tipo de corte e as dimensões do diamante
diamonds %>% ggplot() + 
  geom_bar(mapping = aes(x = cut, fill = cut)) # e se eu quisesse todas as barras vermelhas?
# ```
# 
# ## Alterando as cores das barras
# Similarmente ao gráfico de pontos, podemos alterar a cor das barras com o argumento 
# `fill` (mas isso não é muito útil - por quê?)
# 
# ```{r fig.height = 3.5, fig.align="center"}
# relação entre o tipo de corte e as dimensões do diamante
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
# ```
# 
# ## Definindo cores por claridade
# Seria mais útil definir as cores por alguma informação que já não é transmitida 
# pelo gráfico. Por exemplo, discriminando os diamantes pela claridade.
# 
# ```{r fig.height = 3.5, fig.align="center"}
diamonds %>% ggplot() + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
# ```
# 
# ## Ajustando o posicionamento dos elementos
# A ideia de preenhimento (`fill`) é importante porque ela também pode ser usada para 
# alterar a disposição dos elementos gráficos. Por exemplo, se quisermos um gráfico de 
# barras com valores relativos, podemos preencher toda a área de plotagem:
#   
#   ```{r fig.height = 3.5, fig.align="center"}
diamonds %>% ggplot() + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
# ```


# ## Ajustando o posicionamento dos elementos
# Alternativamente, podemos querer que os elementos gráficos "desviem" (*dodge*) uns 
# dos outros, de modo a não ficarem empilhados:
#   
#   ```{r fig.height = 4, fig.align="center"}
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
# ```
# 
# ## Definição de coordenadas
# 
# ## Definição de coordenadas
# Outro modo de alterar a disposição dos elementos no gráfico é alterar suas coordenadas. 
# Vamos voltar ao nosso gráfico de diamantes por corte:
#   
#   ```{r fig.height = 3.5, fig.align="center"}
diamonds %>% ggplot() + 
  geom_bar(mapping = aes(x = cut, fill = cut))
# ```
# 
# ## Definição de coordenadas
# Uma primeira transformação de coordenadas relativamente óbvia é tornar as barras horizontais. Para isso, basta usar a 
# função `coord_flip()`
# 
# ```{r fig.height = 3.5, fig.align="center"}
diamonds %>% ggplot() + 
  geom_bar(mapping = aes(x = cut, fill = cut)) +
  coord_flip()
# ```
# 
# ## Definição de coordenadas
# Uma transformação não tão óbvia é fazer com que as barras saiam de um mesmo ponto, 
# com dispersão radial.
# 
# ```{r fig.height = 4, fig.align="center"}
diamonds %>% ggplot() + 
  geom_bar(mapping = aes(x = cut, fill = cut)) +
  coord_polar()
# ```
# 
# ## Animações
# 
# ## Para fazer animações, use o pacote `gganimate`
# ```{r fig.show="hide", message=FALSE, warning=FALSE, fig.height=5,}
library(gganimate)
library(gapminder)

gapminder %>% ggplot(aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  # Código específico para a animação
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')
# ```
# 
# ## Resultado
# ```{r echo=FALSE, message=FALSE, warning=FALSE, fig.height=5,}
library(gganimate)
library(gapminder)

gapminder %>% ggplot(aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  # Código específico para a animação
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')
# ```
# 
# ## Eixo X dinâmico
# ```{r echo=FALSE, message=FALSE, warning=FALSE, fig.height=5,}
gapminder %>% ggplot(aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  # Código específico para a animação
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  labs(title = "Year: {frame_time}") +
  view_follow(fixed_y = TRUE)
# ```
# 
# ## Rastro para os pontos
# ```{r echo=FALSE, message=FALSE, warning=FALSE, fig.height=5,}
gapminder %>% ggplot(aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  # Código específico para a animação
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  labs(title = "Year: {frame_time}") +
  shadow_wake(wake_length = 0.2, alpha = FALSE)
# ```
# 
# ## Países separados por continente
# ```{r echo=FALSE, message=FALSE, warning=FALSE, fig.height=5,}
gapminder %>% ggplot(aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Código específico para a animação
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')
# ```
# 
# ## Datasaurus
# ```{r echo=FALSE, message=FALSE, warning=FALSE}
library(datasauRus)

datasaurus_dozen %>% ggplot(aes(x = x, y = y)) +
  geom_point() +
  theme_minimal() +
  transition_states(dataset, 3, 1) + 
  ease_aes('cubic-in-out')
# ```
# 
# ## Temperaturas
# ```{r echo=FALSE, message=FALSE, warning=FALSE, fig.height=5,}
airq <- airquality
airq$Month <- format(ISOdate(2004,1:12,1),"%B")[airq$Month]

airq %>% ggplot(aes(Day, Temp, group = Month)) + 
  geom_line() + 
  geom_segment(aes(xend = 31, yend = Temp), linetype = 2, colour = 'grey') + 
  geom_point(size = 2) + 
  geom_text(aes(x = 31.1, label = Month), hjust = 0) + 
  transition_reveal(Day) + 
  coord_cartesian(clip = 'off') + 
  labs(title = 'Temperature in New York', y = 'Temperature (°F)') + 
  theme_minimal() + 
  theme(plot.margin = margin(5.5, 40, 5.5, 5.5))
# ```
# 
# ## Concluindo
# O que vimos é mais do que uma ferramenta de criação de gráficos. É uma sintaxe completa 
# que permite **pensar** na informação que você quer transmitir e **produzir** praticamente 
# qualquer tipo de gráfico que se adeque às suas necessidades.
# 
# O `ggplot()` permite uma infinidade de tipos de gráficos. Não valeria a pena fazer 
# uma varredura extensa neste momento, pois isso seria maçante e acabaria atrapalhando 
# a absorção dos fundamentos da gramática dos gráficos. **À medida em que avançarmos com as análises, vamos vendo aos poucos a aplicação desses princípios em vários tipos de gráficos**. 
# 
# ## Material adicional
# 
# - [Aula Hadley Wikham](http://stat405.had.co.nz/lectures/20-effective-vis.pdf)
# - [r-graph-gallery](https://www.r-graph-gallery.com/)
# - [ggplot flipbook](https://evamaerey.github.io/ggplot_flipbook/ggplot_flipbook_xaringan.html#1)
#                     - [Galeria](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html)
#                     - [Sobre gráficos de pizza](https://stats.stackexchange.com/questions/8974/problems-with-pie-charts)
#                     
#                     ## Tarefa da aula
#                     
#                     As instruções da tarefa estão no arquivo `NN-class-ds4ir-assignment.rmd` da pasta 
#                     `assignment` que se encontra na raiz desse projeto.
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    