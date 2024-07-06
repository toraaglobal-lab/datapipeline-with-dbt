# Building a Data Pipeline with dbt

A Comprehensive Guide for Aspiring Data Engineers

##  Introduction to Data Pipelines
* Definition: A data pipeline is a series of processes that move data from a source to a destination, transforming it along the way.
* Importance: Critical for data analytics, machine learning, and business intelligence.
* Components:
    - Data Ingestion
    - Data Storage
    - Data Transformation
    - Data Load

## Introduction to dbt (Data Build Tool)

[What is dbt?](https://docs.getdbt.com/docs/introduction)

dbt is a transformation workflow that helps you get more work done while producing higher quality results. You can use dbt to modularize and centralize your analytics code, while also providing your data team with guardrails typically found in software engineering workflows. Collaborate on data models, version them, and test and document your queries before safely deploying them to production, with monitoring and visibility.
![](./img/cloud-overview.jpg)

* Features:
    - SQL-based transformation
    - Version control
    - Modular approach
    - Automated documentation
    - Testing capabilities

* [Quickstart for dbt Core from a manual install](https://docs.getdbt.com/guides/manual-install?step=1)


## The dbt Workflow
* Development: Write SQL transformations and tests.
* Testing: Validate transformations with tests.
* Documentation: Automatically generate documentation.
* Deployment: Run transformations in production.

## Setting up development environment 
**Github**

- Create a github repo for your project 
- clone the repo to your development environment `git clone repo-url`
- create a virtual environment to isolate your develpment modules `virtualenv venv`
- activate the virtual environment `source venv/bin/activate`


[Mkdocs](https://www.mkdocs.org/getting-started/)

MkDocs is a fast, simple and downright gorgeous static site generator that's geared towards building project documentation. 

- installation using pip `pip install mkdocs`
- create a new project `mkdocs new .`
- use this command ` mkdocs serve` to serve the document locally 


[Creating your site](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site#creating-your-site)
- On GitHub, navigate to your site's repository.
- Under your repository name, click  Settings. If you cannot see the "Settings" tab, select the  dropdown menu, then click Settings.

- [add workflow](https://github.com/toraaglobal-lab/Building-a-Data-Pipeline-with-dbt/blob/main/.github/workflows/ci.yml)



## Setting Up dbt
- Installation: Install dbt using pip.
    ```
    pip install dbt-core
    python -m pip install dbt-postgres
    ```
     
- Initialization: Initialize a new dbt project.
    - Make sure you have dbt Core installed and check the version using the dbt --version command
        ```
        dbt --version
        ```
    - Initiate the `project_name` project using the init command
        ```
        dbt init project_name
        ```
- Configuration: Configure profiles and database connections.
    - ~/.dbt/profiles.yml
        ```
        # example profiles.yml file
        jaffle_shop:
        target: dev
        outputs:
            dev:
            type: postgres
            host: localhost
            user: alice
            password: <password>
            port: 5432
            dbname: jaffle_shop
            schema: dbt_alice
            threads: 4
        ```

- Perform your first dbt run to check connectivity
    ```
    dbt run 
    ```

- [Build your first model](https://docs.getdbt.com/guides/manual-install?step=9)
    - seed data from csv to database `dbt seed `
    - create your first model 



- Add tests to your models
Adding tests to a project helps validate that your models are working correctly.

To add tests to your project:

    - Create a new YAML file in the models directory, named models/schema.yml

    - Add the following contents to the file:
        ```
        version: 2

        models:
        - name: customers
            columns:
            - name: customer_id
                tests:
                - unique
                - not_null

        - name: stg_customers
            columns:
            - name: customer_id
                tests:
                - unique
                - not_null

        - name: stg_orders
            columns:
            - name: order_id
                tests:
                - unique
                - not_null
            - name: status
                tests:
                - accepted_values:
                    values: ['placed', 'shipped', 'completed', 'return_pending', 'returned']
            - name: customer_id
                tests:
                - not_null
                - relationships:
                    to: ref('stg_customers')
                    field: customer_id

        ```


- Generate documents
    ```
    dbt docs generate
    dbt docs serve
    ```
    - copy docs generated to mkdocs static website
    ```
    ```


- Schedule a job

