#  End-to-End Omnichannel Analytics Engineering Pipeline

![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)

##  Executive Summary
This project demonstrates a production-grade Analytics Engineering pipeline. It extracts operational omnichannel data from a traditional RDBMS (SQL Server) and transforms it into an analytics-ready dimensional model within Snowflake using dbt (data build tool). 

The primary business objective is to break down data silos between web, mobile, and in-store channels to build unified customer profiles, analyze cross-channel visit behavior, and identify cross-selling opportunities to drive revenue growth.

##  Architecture & Data Flow

Our architecture follows a modern ELT (Extract, Load, Transform) pattern and implements a Medallion data architecture (Bronze, Silver, Gold) within Snowflake.

```text
[SQL Server] 
     │ (Extraction)
     ▼
[Snowflake RAW / Bronze] ───> Raw, untransformed JSON/Tabular loads
     │ (dbt source)
     ▼
[Snowflake STG / Silver] ───> Cleansed, standardized, typed data (stg_models)
     │ (dbt ref)
     ▼
[Snowflake MART / Gold]  ───> Business-level facts & dimensions (fct_, dim_)
     │
     ▼
[BI & Analytics]         ───> Dashboards & Ad-hoc SQL querying

```

##  Business Problem & Data Model

To optimize our omnichannel strategy, the business requires visibility into customer interactions across all platforms.

**Source Operational Tables (SQL Server):**

* **Entities:** `Customers`, `Products`, `Channels`
* **Transactions/Events:** `PurchaseHistory`, `VisitHistory`

**Target Analytical Model (Snowflake):**
The final Gold layer exposes a star schema designed for fast analytical querying, calculating key metrics such as channel bounce rates, customer lifetime value (CLV), and product affinity.

##  dbt Project Structure

The project leverages dbt best practices, including modularity, strict naming conventions, and separation of concerns.

```text
my_omni_project/
├── models/
│   ├── staging/                 # Silver Layer: Cleansing & Renaming
│   │   ├── _sources.yml         # Source definitions & freshness tests
│   │   ├── stg_customers.sql
│   │   ├── stg_products.sql
│   │   ├── stg_channels.sql
│   │   ├── stg_purchase_history.sql
│   │   └── stg_visit_history.sql
|   |   └── schema.yml
│   │
│   └── marts/                   # Gold Layer: Business Logic & Aggregations
│       ├── core/
│       │   ├── dim_customers.sql
│       │   ├── dim_products.sql
│       │   └── dim_channels.sql
│       └── finance/
│           └── fct_purchases.sql
├── dbt_project.yml
└── README.md

```

##  Key Technical Implementations

* **Source Configuration (`source()`):** Abstracted raw table references in Snowflake to allow for easy environment switching (Dev/QA/Prod).
* **Modular Transformations (`ref()`):** Built a DAG (Directed Acyclic Graph) where models build logically upon one another, ensuring DRY (Don't Repeat Yourself) code.
* **Surrogate Keys:** Implemented robust key generation for dimensional tables to handle historical changes and slowly changing dimensions (SCDs).
* **Audit Logging:** Leveraged source system `CREATED_AT` and `UPDATED_AT` timestamps to prepare the architecture for future incremental loading.

##  Setup & Execution

### Prerequisites

* Python 3.8+
* Access to a Snowflake Account (with appropriate role/warehouse grants)
* dbt-snowflake adapter installed

### Installation Steps

1. **Clone the repository:**
```bash
git clone [https://github.com/Shekhimran/omnichannel-analytics.git](https://github.com/Shekhimran/my_snowflake_project.git)


```


2. **Install dependencies:**
```bash
pip install dbt-snowflake
dbt deps

```


3. **Configure your `profiles.yml`:**
Ensure your local dbt profile is set up to connect to your Snowflake `DEV` database and warehouse.
4. **Run the pipeline:**
```bash
# Test source data connections
dbt debug

# Build the models
dbt run

# Run data quality tests (uniqueness, non-null, referential integrity)
dbt test

```



##  Future Roadmap

To further mature this pipeline, the following enhancements are planned:

* **Incremental Materializations:** Transitioning `fct_purchases` from a table to an incremental model to reduce Snowflake compute costs.
* **Snowflake Streams & Tasks:** Automating the ingestion from the RAW layer to STAGE without requiring external orchestrators.
* **CI/CD Integration:** Implementing GitHub Actions to run `dbt build` on pull requests to ensure code quality before merging to main.



**Author:** Shekh Imran

*Data & Analytics Engineering*



