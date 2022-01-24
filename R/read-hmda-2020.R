
library(tidyverse)

## Read in 2020 data

hmda2020 <- read_delim("C:/hmda/data/2020_lar.txt",
                       delim = "|",
                       col_types = cols(
                         activity_year = col_double(),
                         lei = col_character(),
                         derived_msa_md = col_double(),
                         state_code = col_character(),
                         county_code = col_character(),
                         census_tract = col_character(),
                         conforming_loan_limit = col_character(),
                         derived_loan_product_type = col_character(),
                         derived_dwelling_category = col_character(),
                         derived_ethnicity = col_character(),
                         derived_race = col_character(),
                         derived_sex = col_character(),
                         action_taken = col_double(),
                         purchaser_type = col_double(),
                         preapproval = col_double(),
                         loan_type = col_double(),
                         loan_purpose = col_double(),
                         lien_status = col_double(),
                         reverse_mortgage = col_double(),
                         open_end_line_of_credit = col_double(),
                         business_or_commercial_purpose = col_double(),
                         loan_amount = col_double(),
                         combined_loan_to_value_ratio = col_character(),
                         interest_rate = col_character(),
                         rate_spread = col_character(),
                         hoepa_status = col_double(),
                         total_loan_costs = col_character(),
                         total_points_and_fees = col_character(),
                         origination_charges = col_character(),
                         discount_points = col_character(),
                         lender_credits = col_character(),
                         loan_term = col_character(),
                         prepayment_penalty_term = col_character(),
                         intro_rate_period = col_character(),
                         negative_amortization = col_character(),
                         interest_only_payment = col_character(),
                         balloon_payment = col_character(),
                         other_nonamortizing_features = col_character(),
                         property_value = col_character(),
                         construction_method = col_double(),
                         occupancy_type = col_double(),
                         manufactured_home_secured_property_type = col_double(),
                         manufactured_home_land_property_interest = col_double(),
                         total_units = col_character(),
                         multifamily_affordable_units = col_character(),
                         income = col_double(),
                         debt_to_income_ratio = col_character(),
                         applicant_credit_score_type = col_double(),
                         co_applicant_credit_score_type = col_double(),
                         applicant_ethnicity_1 = col_double(),
                         applicant_ethnicity_2 = col_double(),
                         applicant_ethnicity_3 = col_double(),
                         applicant_ethnicity_4 = col_double(),
                         applicant_ethnicity_5 = col_double(),
                         co_applicant_ethnicity_1 = col_double(),
                         co_applicant_ethnicity_2 = col_double(),
                         co_applicant_ethnicity_3 = col_double(),
                         co_applicant_ethnicity_4 = col_double(),
                         co_applicant_ethnicity_5 = col_double(),
                         applicant_ethnicity_observed = col_double(),
                         co_applicant_ethnicity_observed = col_double(),
                         applicant_race_1 = col_double(),
                         applicant_race_2 = col_double(),
                         applicant_race_3 = col_double(),
                         applicant_race_4 = col_double(),
                         applicant_race_5 = col_double(),
                         co_applicant_race_1 = col_double(),
                         co_applicant_race_2 = col_double(),
                         co_applicant_race_3 = col_double(),
                         co_applicant_race_4 = col_double(),
                         co_applicant_race_5 = col_double(),
                         applicant_race_observed = col_double(),
                         co_applicant_race_observed = col_double(),
                         applicant_sex = col_double(),
                         co_applicant_sex = col_double(),
                         applicant_sex_observed = col_double(),
                         co_applicant_sex_observed = col_double(),
                         applicant_age = col_character(),
                         co_applicant_age = col_character(),
                         applicant_age_above_62 = col_character(),
                         co_applicant_age_above_62 = col_character(),
                         submission_of_application = col_double(),
                         initially_payable_to_institution = col_double(),
                         aus_1 = col_double(),
                         aus_2 = col_double(),
                         aus_3 = col_double(),
                         aus_4 = col_double(),
                         aus_5 = col_double(),
                         denial_reason_1 = col_double(),
                         denial_reason_2 = col_double(),
                         denial_reason_3 = col_double(),
                         denial_reason_4 = col_double(),
                         tract_population = col_double(),
                         tract_minority_population_percent = col_double(),
                         ffiec_msa_md_median_family_income = col_double(),
                         tract_to_msa_income_percentage = col_double(),
                         tract_owner_occupied_units = col_double(),
                         tract_one_to_four_family_homes = col_double(),
                         tract_median_age_of_housing_units = col_double()
                       ))



## Separate reverse and HELOC

rev <- hmda2020 %>% 
  filter(reverse_mortgage == 1 |
         open_end_line_of_credit == 1)


## Write our reverse and HELOC
write_csv(rev,
          "C:/hmda/data/reverse_2020.csv")


## Write out full with limited variables


