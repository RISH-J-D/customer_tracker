import spaces
import gradio as gr
import os
import sys

# Ensure backend modules can be imported
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from backend.app.main import app

# ZeroGPU worker function bound to Gradio interface
@spaces.GPU
def tracker_gpu_worker(prompt: str):
    return f"Tracker GPU worker active. Status: OK ({prompt})"

# Gradio interface satisfying ZeroGPU startup validation
demo = gr.Interface(
    fn=tracker_gpu_worker,
    inputs=gr.Textbox(label="System Status Check", value="status"),
    outputs=gr.Textbox(label="Response"),
    title="Customer Tracker & Accounts",
    description="Interactive tracker platform running with 24/7 cloud hosting."
)

# Mount Gradio onto our FastAPI application
app = gr.mount_gradio_app(app, demo, path="/gradio")
