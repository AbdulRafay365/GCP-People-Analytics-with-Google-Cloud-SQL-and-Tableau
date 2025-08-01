<table style="border-collapse: collapse; border: none;">
  <tr>
    <td style="vertical-align: middle; border: none; padding: 0;">
      <img src="https://github.com/user-attachments/assets/d9a91eb3-91df-4a40-8568-094f1180a593" 
           alt="google-cloud" 
           height="100" />
    </td>
    <td style="vertical-align: middle; border: none; padding: 0 0 0 12px;">
      <h1 style="margin: 0;">GCP: People Analytics with Google Cloud SQL and Tableau</h1>
    </td>
  </tr>
</table>

---

## About the Project

<div align="center">
  <img width="200" height="200" alt="project-logo" src="https://github.com/user-attachments/assets/cfdfd4a4-ad09-4e63-b487-76f975ded2c4" />
</div>

In this project, I explored the domain of **People Analytics**, emphasizing its value in making data-driven decisions about a company’s most critical resource — its people. 

Through this journey, I:

- Learned the **fundamentals of People Analytics** and its real-world applications.
- **Generated realistic HR datasets** using Python.
- **Processed and stored** the data using Google Cloud SQL.
- **Performed ad-hoc reporting** and query-based exploration with SQL.
- Built an interactive **dashboard in Tableau** focused on **employee demographics** and **income trends**.

The end goal was to complete the full People Analytics cycle — from data wrangling to insight generation.

---

## What is People Analytics?

> *People analytics is the practice of collecting and analyzing workforce data to convert it into actionable insights that improve organizational outcomes.*  
> — [Visier](https://www.visier.com/people-analytics/#what-is-people-analytics)

Also known as **Workforce Analytics** or **HR Analytics**, People Analytics focuses on employee-centric data and helps HR professionals solve problems like:

- High turnover  
- Low engagement  
- Skill gaps  
- Diversity and inclusion metrics

> Note: While traditional **reporting** provides static summaries, **people analytics** uses advanced techniques to **uncover patterns**, **predict outcomes**, and **inform strategic decisions**.

---

## The Three Pillars of People Analytics  
_Source: [Visier](https://www.visier.com/people-analytics/#what-is-people-analytics)_

1. **Data**  
   Sourced from tools like HRIS, ATS, HCM, and payroll systems — the raw foundation of people analytics.

2. **Analytics**  
   The process of transforming raw data into insights using statistical models, SQL queries, and machine learning.

3. **Insights**  
   Delivered in the form of dashboards, charts, and reports that support decision-making at all organizational levels.

---

## What is a People Analytics Strategy?

> *A People Analytics strategy outlines how to systematically use workforce data to solve business challenges.*  
> — [Visier](https://www.visier.com/people-analytics/#what-is-people-analytics)

<div align="center">
  <img src="https://github.com/user-attachments/assets/128a0e5e-daa7-47b0-90b9-70b368602771" alt="people-analytics-strategy" />
</div>

---

## Tools & Technologies Used

<div align="center">

<table>
  <tr>
    <th>Tool</th>
    <th>Purpose</th>
  </tr>
  <tr>
    <td><strong>Python</strong></td>
    <td>Data generation & preprocessing</td>
  </tr>
  <tr>
    <td><strong>Google Cloud SQL</strong></td>
    <td>Data warehousing & query storage</td>
  </tr>
  <tr>
    <td><strong>SQL</strong></td>
    <td>Ad-hoc analysis and metrics tracking</td>
  </tr>
  <tr>
    <td><strong>Tableau</strong></td>
    <td>Data visualization & dashboarding</td>
  </tr>
</table>

</div>

---

## Sections  

### 1. Process  
- **Dataset**: Started with ~9,000 records in a flat structure.  
- **Database Design**:  
  - Created a **star schema** (fact/dimension tables) for optimized analytics.  
  - Designed the ERD using **SmartDraw**.  
  - Implemented the schema via **PostgreSQL** (using PG Admin).  
- **ETL Pipeline**:  
  - Loaded raw data into a staging table.  
  - Transformed/cleaned data before loading into the star schema.  
- **Scalability & Cloud Migration**:  
  - Migrated the database to **Google Cloud SQL** for accessibility and reporting.  

### 2. Analytics & Reporting  
- **SQL Reports**: Wrote 15 SQL queries to answer key business questions.  
- **Visualization**:  
  - Initially planned to use **Looker** (GCP integration issues prevented this).  
  - Switched to **Tableau**, built a semantic model, and designed an interactive dashboard.  
  - Dashboard features:  
    - Personnel demographics (gender, age, education).  
    - Income trends by location/role.  
    - Other HR-centric KPIs.  

### 3. Development Approach  
- **Agile (Scrum)**:  
  - 4 iterations (1 day each) due to time constraints.  
  - Focused on incremental improvements (data model → reports → dashboard).  
- **Inspiration**:  
  - Credit to [Data With Baraa](https://www.youtube.com/@DataWithBaraa) for dashboard design ideas.  

### 4. Tools & Technologies  
- **Database**: PostgreSQL (local + Google Cloud SQL).  
- **Design**: SmartDraw (ERD).  
- **ETL**: SQL scripts for staging → star schema.  
- **Visualization**: Tableau.  

---

## Key Outcomes  
- Optimized star schema database for analytics.  
- Shareable cloud-hosted SQL reports.  
- Interactive Tableau dashboard for HR insights.  
<img width="2280" height="1122" alt="image" src="https://github.com/user-attachments/assets/2578d354-6122-4d52-acae-ff13444934a8" />

> _"Without data, you're just another person with an opinion."_  
> — W. Edwards Deming

---
