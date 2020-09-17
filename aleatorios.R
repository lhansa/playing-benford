library(tidyverse)

walk(list.files("src", pattern = ".R", full.names = TRUE), source)

n_digits <- 1e6
maximo <- 999999

digits_1 <- trunc(maximo * runif(n_digits)) + 1
digits_2 <- trunc(maximo * runif(n_digits)) + 1

df <- tibble(
  d1 = digits_1, 
  d2 = digits_2
)

df <- df %>% 
  mutate(
    # benford = digits_1 ^ 2, 
    benford = digits_1 ^ 2 / digits_2,
    primero = calcula_primero(benford)) %>% 
  filter(primero > 0)

ggplot(df, aes(x = primero)) + 
  geom_bar(aes(y = ..prop..)) +
  geom_text(aes(y = ..prop.., 
                label = scales::percent(..prop..)), 
            stat= "count",
            vjust = -.5) + 
  scale_x_continuous(breaks = 1:9) + 
  labs(
    title = "Números generados aleatoriamente", 
    subtitle = "(unif1) ^ 2 / unif2", 
    x = "Primer dígito", y = "Proporción", 
    caption = "Datos simulados."
  )
