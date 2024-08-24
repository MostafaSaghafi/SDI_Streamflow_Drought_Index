# Load the readxl package
library(readxl)

# Read the Excel file
data <- read_xlsx(path = "C:\\Users\\Mostafa\\Desktop\\dd.xlsx", sheet = "Sheet3")

# Load the drought package
library(drought)
library(tidyverse)

# Compute the 12-month SDI using the gamma distribution
sdi_12 <- SDI(data$Flow, ts = 6, dist = "EmpGrin")
sdi_12$SDI
z=matrix(t(sdi_12$SDI), ncol = 1)
plot(z, type = "l", col = 1, lwd = 2,lty=1, xlab = "Month"  , ylab = "SDI")

df <- data.frame(sdi_12$SDI) 
df$Year <- (1360:1399)

SDI_year <- df %>%
  pivot_longer(cols = X1:X12, names_to = "Month", values_to = "value" ) %>%
  mutate(Year=Year)

#SDI_year <- SDI_year %>%
  #group_by(Year, Month) %>% 
 # summarise(SDI=mean(value))


ggplot(SDI_year, aes(x=Year, y=value, group=Year)) + 
  geom_line()+
  geom_hline(yintercept = 0, color="red")+
  labs(title = "standardized drought index Plot", x= "Year", y="SDI")+
  theme_minimal()