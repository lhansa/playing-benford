library(tidyverse)

walk(list.files("src", pattern = ".R", full.names = TRUE), source)

# Source: datadista
ruta <- "https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_casos.csv"

# ccaa_covid19_casos.csv
df_covid <- read_csv(ruta, col_types = cols())

df_covid_benford <- df_covid %>% 
  pivot_longer(cols = -c(cod_ine, CCAA)) %>% 
  filter(value > 0) %>% 
  mutate(primero = calcula_primero(value))

df_benford <- tibble(
  eje_x = 1:9, 
  benford = log10(1 + 1/1:9) 
)
 
# Contagiados acumulados
df_covid_benford %>% 
  ggplot(aes(x = primero)) + 
  geom_bar(aes(y = ..prop..)) +
  geom_line(data = df_benford, aes(x = eje_x, y = benford), 
            col = "red", size = 1) + 
  geom_text(aes(y = ..prop.., 
                label = scales::percent(..prop..)), 
            stat= "count",
            vjust = -.5) + 
  scale_x_continuous(breaks = 1:9) + 
  labs(
    title = "Primer dígito del número de casos de Covid", 
    subtitle = "Datos diarios, por CCAA, desde el 21 de febrero", 
    x = "Primer dígito", y = "Proporción", 
    caption = "Fuente (datos): Datadista."
  )

# Contagiados no acumulados
df_covid_nocum <- df_covid_benford %>% 
  group_by(cod_ine, CCAA) %>% 
  mutate(value = value - lag(value)) %>% 
  ungroup() %>% 
  filter(!is.na(value), value > 0) %>% 
  mutate(primero = calcula_primero(value))

df_covid_nocum %>% 
  ggplot(aes(x = primero)) + 
  geom_bar(aes(y = ..prop..)) +
  geom_line(data = df_benford, aes(x = eje_x, y = benford), 
            col = "red", size = 1) + 
  geom_text(aes(y = ..prop.., 
                label = scales::percent(..prop..)), 
            stat= "count",
            vjust = -.5) + 
  scale_x_continuous(breaks = 1:9) + 
  labs(
    title = "Primer dígito del número de casosde Covid", 
    subtitle = "Datos diarios (no cum), por CCAA, de febrero a mayo", 
    x = "Primer dígito", y = "Proporción", 
    caption = "Fuente (datos): Datadista."
  )

## Contagiados no cum, por CCCAA

df_covid_nocum %>% 
  ggplot(aes(x = primero)) + 
  geom_bar(aes(y = ..prop..)) +
  geom_line(data = df_benford, aes(x = eje_x, y = benford), 
            col = "red", size = 1) + 
  geom_text(aes(y = ..prop.., 
                label = scales::percent(..prop..)), 
            stat= "count",
            vjust = -.5) + 
  facet_wrap(~ CCAA) + 
  scale_x_continuous(breaks = 1:9) + 
  labs(
    title = "Primer dígito del número de casosde Covid", 
    subtitle = "Datos diarios (no cum), por CCAA, de febrero a mayo", 
    x = "Primer dígito", y = "Proporción", 
    caption = "Fuente (datos): Datadista."
  )
