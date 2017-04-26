## ---- eval=FALSE---------------------------------------------------------
## install.packages("ggplot2")

## ------------------------------------------------------------------------
library('ggplot2')

## ---- fig.align='center', fig.height=6-----------------------------------
df <- data.frame(A = c(1:10), B = seq(22, 4, by= -2))
ggplot(data = df, aes(x = A, y = B)) + geom_point()

## ---- eval=FALSE---------------------------------------------------------
## install.packages('gapminder')
library('gapminder')

## ------------------------------------------------------------------------
gapminder <- readRDS('data/gapminder.rds')

## ------------------------------------------------------------------------
gapminder2007 <- subset(gapminder, year==2007)

## ---- tidy=FALSE, message=FALSE, fig.align='center', fig.height=6--------
ggplot(data=gapminder2007, aes(x=gdpPercap)) + 
        geom_histogram()

## ---- tidy=FALSE, message=FALSE, warning=FALSE, out.width =  '400px'-----
ggplot(data=gapminder2007, aes(x=gdpPercap)) + 
        geom_histogram(binwidth=10000)

## ---- tidy=FALSE, message=FALSE, warning=FALSE, out.width =  '400px'-----
ggplot(data=gapminder2007, aes(x=gdpPercap)) + 
        geom_histogram(binwidth=800)

## ---- fig.align='center',fig.height=4------------------------------------
ggplot(data=gapminder2007, aes(x=continent)) + geom_bar()

## ---- fig.align='center',fig.height=4, message=FALSE, warning=FALSE------
library('dplyr')
gapminder2007_2 <- gapminder2007 %>% group_by(continent) %>% summarise(number=n())
ggplot(data=gapminder2007_2, aes(x=continent, y=number)) + geom_col()

## ---- fig.align='center',fig.height=6------------------------------------
gapminder2 <- gapminder %>% group_by(year) %>% summarise(mean.lifeExp=mean(lifeExp, na.rm=TRUE))
ggplot(data=gapminder2, aes(x=year, y=mean.lifeExp)) + geom_line()

## ---- fig.align='center',fig.height=6------------------------------------
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp)) + geom_point()

## ---- fig.align='center',fig.height=6------------------------------------
ggplot(data=gapminder2007, aes(x=continent, y=lifeExp)) +
        geom_boxplot()

## ---- fig.align='center',fig.height=6------------------------------------
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, color=pop)) +
        geom_point()

## ---- fig.align='center',fig.height=6------------------------------------
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, size=pop)) +
        geom_point()

## ---- fig.align='center',fig.height=6------------------------------------
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, color=continent)) +
        geom_point()

## ---- fig.align='center',fig.height=6------------------------------------
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, shape=continent)) + 
        geom_point() + scale_shape(solid = FALSE)

## ---- fig.align='center', fig.height=6-----------------------------------
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, color=pop)) +
        geom_point()+ 
        scale_colour_gradientn(colours=rainbow(5))

## ---- fig.align='center', fig.height=6-----------------------------------
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, color=log10(pop))) +
        geom_point()

## ---- fig.align='center',fig.height=5, message=FALSE---------------------
ggplot(data=gapminder2007, aes(x=lifeExp)) + 
        geom_histogram() + 
        facet_wrap(~continent)

## ---- tidy=FALSE, message=FALSE, warning=FALSE, fig.align='center', fig.height=5----
p <- ggplot(data=gapminder2007, aes(x=lifeExp, y=gdpPercap, color=continent)) +
        geom_point()
p <- p + labs(x='Life expectancy', y=NULL,
              title='GDP vs Life expectancy', color='Continent: ')
p

## ---- tidy=FALSE, message=FALSE, warning=FALSE, fig.align='center', fig.height=6----
p <- p + theme_bw()
p

## ---- tidy=FALSE, message=FALSE, fig.align='center', fig.height=3--------
p <- ggplot(data=gapminder2007, aes(x=lifeExp, y=gdpPercap, color=continent)) +
        geom_point() +
        labs(x='Life expectancy', y=NULL, title='GDP vs Life expectancy', color='Continent: ') +
        theme_bw()
p

## ---- tidy=FALSE, message=FALSE, eval=FALSE------------------------------
## ggsave(filename = "Plot.pdf", plot = p)

## ---- tidy=FALSE, message=FALSE, eval=FALSE------------------------------
## ggsave(filename = "Plot.png", plot = p, dpi = 300)

## ---- message=FALSE, fig.height=4, eval=FALSE----------------------------
## # devtools::install_github("ropensci/plotly")
library('plotly')
ggplotly(p=p)

## ---- message=FALSE, eval=FALSE------------------------------------------
library('dygraphs')
library('tidyr')
gapminder3 <- gapminder %>%
        group_by(year, continent) %>%
        summarise(mean.lifeExp=mean(lifeExp, na.rm=TRUE)) %>%
        spread(continent, mean.lifeExp)
dygraph(gapminder3) %>% dyRangeSelector()

