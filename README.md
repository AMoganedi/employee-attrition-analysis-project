# employee-attrition-analysis-project
### Project Overview
In this project we focus on employee tenure in a company. Specifically, we
are investigating the tenure period where attrition spikes as well as some
factors that may shed light on why some employees left the company. The
aim is for the company to improve employee retention. The dataset is from
IBM.

### Data Source
https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset

### Tools
- Python
- MySQL
- Microsoft Word

### Data Cleaing
Used MySQL and Python to perform cleaning:
- Removed erroneous entries
- Edited column names

### Understanding the data
The exploratory data analysis phase included the following:
- Calculating range, mean, mode and median for measure
- Studied the distribution of each measure using normality tests method such as Shapiro-Wilk, DAgostinos K^2, & Anderson-Darling test and a histogram
- Studied the association between attrition and other categorical variables
- Calculated the interquartile range and Kurtosis to look for statistical outliers

### Data Analysis
> Identifying which ordinal variable as a significant association with attrition
```python
alpha = 0.05
variables = ["Education", "EnvironmentSatisfaction", "JobInvolvement", "JobSatisfaction", "PerformanceRating", "RelationshipSatisfaction", "WorkLifeBalance"]

bonferroni_threshold = alpha/len(variables)

rows = []
for var in variables:
    chi2,pvalue,dof,_= stats.chi2_contingency(pd.crosstab(df[var],df["Attrition"]))
    rows.append({"Variable": var, "Chi2": chi2, "P_Value": pvalue, "DOF": dof})

results_df = pd.DataFrame(rows)
results_df["Significant"]=results_df["P_Value"] < bonferroni_threshold

print(f"Bonferroni threshold: {bonferroni_threshold:.4f}\n")
print(results_df.round(2))
```

> Post-hoc test to further observe the association between attrition and ordinal values
```python
residuals = observed.values
standardised_residuals = (residuals - expected_values)/np.sqrt(expected_values)

residuals_df = pd.DataFrame(
    standardised_residuals,
    index=observed.index,
    columns=observed.columns
).round(2)

print(residuals_df)
```

### Key Findings
- Newer employees are more likely to leave the company at a higher
rate than older employees. Furthermore, the ages with the highest
attrition rates were in between 27 and 35, which indicates that
workers in their late 20s and early 30s were more prone to attrition.
- A poor working environment, low job involvement, job dissatisfaction
and an unhealthy work life balance where disproportionately
associated with employees who left the company.

### Recommendations
In order to incentivise employees to stay longer in the company, managers
can ensure a positive work environment, such as job satisfaction and
promoting a healthy work-life balance, for newer employees. Furthermore,
managers can also ensure that newer employees are tasked with projects
that foster the utilisation of a diverse set of skills instead of highly repetitive
and monotone tasks; this improves job involvement.


