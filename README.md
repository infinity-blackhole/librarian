# Librarian

This repository contains a proof-of-concept (PoC) application that utilizes
LangChain and LangServe to deliver a simple RAG (Retrieval Augmented
Generation).

## Overview

The purpose of this application is to demonstrate the integration of LangChain
and LangServe into a cloud environment, specifically Google Cloud.

## Getting Started

To get started with this application, follow these steps:

1. Clone the repository to your local machine.
2. Install the necessary dependencies using PDM.
3. Configure the Google Cloud credentials.
4. Create a Vertex AI Search Data Store and Application
5. Run the application.
6. Deploy the application to Google Cloud Run using Skaffold.

## Usage

Once the application is up and running, you can access the RAG status by
querying the endpoints following the OpenAPI specification available at
`http://localhost:8000/docs`.
