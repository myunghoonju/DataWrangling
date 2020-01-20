https://juliasilge.com/blog/salary-gender/

library(tidyverse)
filterd_x <-c("PHYS","DISC","PORT","HACK","INSD")

results_raw <- read_csv("breach.csv") %>%
	filter(
		state == 'California',
		records > 1e3,
		records < 1e9
	)
education<- results_raw %>%
	filter(str_detect(Company, "University"))

results <- results_raw %>%
	anti_join(education) %>%
	transmute(
		year = parse_number(year),

		organization = fct_collapse(organization,
			'Public' = c("GOV","MED","NGO"),
			'Private' = c("BSF","BSR","BSO")),
		state,
		breach,
		records
		) %>%
	filter(breach %in% filterd_x)

results