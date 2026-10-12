import spaces

@spaces.GPU
def warmup():
    return "ok"

import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from backend.app.main import app
import gradio as gr

demo = gr.Blocks(title="Customer Tracker & Accounts")
with demo:
    gr.HTML("""
    <div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; text-align: center; padding: 40px;">
        <h2 style="font-size: 24px; font-weight: 700; margin-bottom: 12px; color: #1e293b;">Customer Tracker & Detailing Accounts</h2>
        <p style="color: #64748b; font-size: 15px; margin-bottom: 24px;">Application is running.</p>
        <a href="/" target="_top" style="display: inline-block; padding: 12px 28px; background: #2563eb; color: white; border-radius: 8px; text-decoration: none; font-weight: 600;">
            Open Tracker Dashboard →
        </a>
    </div>
    """)

# Mount Gradio onto the existing FastAPI application
app = gr.mount_gradio_app(app, demo, path="/gradio")
