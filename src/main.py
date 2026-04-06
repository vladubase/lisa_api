from fastapi import FastAPI

# Initialize the core FastAPI application
app = FastAPI(
    title="LISA API",
    description="Logistics Intelligence & Swarm API for Fleet Management",
    version="0.1.0",
)


@app.get("/")
async def read_root():
    """
    Root endpoint verifying the API is active.
    """
    return {
        "status": "online",
        "message": "Welcome to LISA: Logistics Intelligence & Swarm API. The System is ready.",
    }


@app.get("/health")
async def health_check():
    """
    Health check endpoint for Docker and Kubernetes orchestration.
    """
    return {"status": "healthy"}
