import os

from fastapi import FastAPI
from langchain_community.llms.vertexai import VertexAI
from langchain.chains import RetrievalQA
from langchain_community.retrievers.google_vertex_ai_search import GoogleVertexAISearchRetriever
from langserve import add_routes

project_id = os.environ["GOOGLE_CLOUD_PROJECT"]
location_id = os.environ["VERTEXAI_SEARCH_LOCATION_ID"]
data_store_id = os.environ["VERTEXAI_SEARCH_DATA_STORE_ID"]

llm = VertexAI(
    project_id=project_id,
    name="text-bison-32k"
)

retriever = GoogleVertexAISearchRetriever(
    project_id=project_id,
    location_id=location_id,
    data_store_id=data_store_id,
    max_extractive_answer_count=5,
    get_extractive_answers=True,
)

chain = RetrievalQA.from_llm(
    llm=llm,
    retriever=retriever,
)

app = FastAPI(
    title="Librarian",
    version="1.0",
    description="A library of knowledge for the world to explore",
)

add_routes(
    app,
    chain,
    path="/chat",
)
