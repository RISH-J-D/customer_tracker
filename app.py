import spaces
import gradio as gr
import os
import sys

# Ensure backend modules can be imported
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from backend.app.main import app as fastapi_app
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse

# 1. ZeroGPU worker function bound to Gradio event
@spaces.GPU
def gpu_status(text: str):
    return f"Tracker Cloud Worker Online: {text}"

# 2. Gradio interface with active ZeroGPU event listener
with gr.Blocks(title="Customer Tracker & Accounts") as demo:
    gr.HTML("""
    <div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; text-align: center; padding: 30px;">
        <h2 style="font-size: 26px; font-weight: 700; color: #1e293b; margin-bottom: 12px;">Customer Tracker & Accounts Platform</h2>
        <p style="color: #64748b; font-size: 15px; margin-bottom: 24px;">Cloud instance running with 24/7 uptime.</p>
        <a href="/" target="_top" style="display: inline-block; padding: 12px 28px; background: #2563eb; color: white; border-radius: 8px; text-decoration: none; font-weight: 600; box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.25);">
            Open Interactive Dashboard →
        </a>
    </div>
    """)
    inp = gr.Textbox(value="ping", visible=False)
    out = gr.Textbox(visible=False)
    btn = gr.Button("Check", visible=False)
    btn.click(fn=gpu_status, inputs=inp, outputs=out)

# 3. Mount our FastAPI backend onto demo.app
demo.app.mount("/api", fastapi_app)

# 4. Mount React frontend SPA onto demo.app
STATIC_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "backend", "frontend_dist")
if os.path.isdir(STATIC_DIR):
    assets_dir = os.path.join(STATIC_DIR, "assets")
    if os.path.isdir(assets_dir):
        demo.app.mount("/assets", StaticFiles(directory=assets_dir), name="assets")

    @demo.app.get("/")
    def serve_index():
        return FileResponse(os.path.join(STATIC_DIR, "index.html"))

    @demo.app.get("/{full_path:path}")
    def serve_frontend_path(full_path: str):
        if full_path.startswith("api/") or full_path.startswith("gradio"):
            return None
        target = os.path.join(STATIC_DIR, full_path)
        if full_path and os.path.exists(target) and os.path.isfile(target):
            return FileResponse(target)
        return FileResponse(os.path.join(STATIC_DIR, "index.html"))

# 5. Launch demo (Gradio starts on port 7860 and handles ZeroGPU lifecycle)
demo.launch(server_name="0.0.0.0", server_port=7860)
