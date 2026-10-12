import os
import sys

# Add project root to sys.path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# ZeroGPU startup requirement
try:
    import spaces
    @spaces.GPU
    def init_gpu():
        return True
    init_gpu()
except Exception:
    pass

from backend.app.main import app
import gradio as gr

# Gradio interface to satisfy Hugging Face Spaces SDK requirements
demo = gr.Blocks(title="Customer Tracker & Accounts")
with demo:
    gr.HTML("""
    <div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; text-align: center; padding: 40px;">
        <h2 style="font-size: 24px; font-weight: 700; margin-bottom: 12px; color: #1e293b;">Customer Tracker & Detailing Accounts</h2>
        <p style="color: #64748b; font-size: 15px; margin-bottom: 24px;">Launching interactive dashboard...</p>
        <a href="/" target="_top" style="display: inline-block; padding: 12px 28px; background: #2563eb; color: white; border-radius: 8px; text-decoration: none; font-weight: 600; box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2);">
            Open Full Dashboard →
        </a>
    </div>
    <script>
        setTimeout(function() {
            if (window.self === window.top) {
                window.location.href = '/';
            }
        }, 300);
    </script>
    """)

# Mount Gradio onto the existing FastAPI application
app = gr.mount_gradio_app(app, demo, path="/gradio")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=7860)
