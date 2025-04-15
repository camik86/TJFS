import tkinter as tk
from tkinter import messagebox
import subprocess
import os
import sys

class ServerLauncher:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title('项目服务器控制台')
        self.root.iconbitmap(default='')
        self.port = 5050
        self.root_dir = os.path.dirname(sys.executable) if getattr(sys, 'frozen', False) else os.path.dirname(os.path.abspath(__file__))
        
        # GUI布局
        self.frame = tk.Frame(self.root, padx=20, pady=20)
        self.frame.pack(expand=True)
        
        self.btn_start = tk.Button(self.frame, text='启动服务器', command=self.start_server,
                                  width=15, height=2, bg='#4CAF50', fg='white')
        self.btn_start.pack(pady=10)
        
        self.status_text = tk.Text(self.frame, height=8, width=40, state='disabled')
        self.status_text.pack()
        
        self.root.mainloop()

    def log_status(self, message):
        self.status_text.config(state='normal')
        self.status_text.insert('end', message + '\n')
        self.status_text.see('end')
        self.status_text.config(state='disabled')

    def start_server(self):
        self.btn_start.config(state='disabled')
        self.log_status('正在检测运行环境...')
        
        try:
            # 检测Python环境
            py_check = subprocess.run(['py', '--version'], capture_output=True, creationflags=subprocess.CREATE_NO_WINDOW)
            if py_check.returncode == 0:
                self.log_status('使用Python启动HTTP服务')
                subprocess.Popen(
                    ['py', '-m', 'http.server', str(self.port)],
                    cwd=self.root_dir,
                    creationflags=subprocess.CREATE_NO_WINDOW
                )
            else:
                # 检测Node.js环境
                npm_check = subprocess.run(['npm', '--version'], capture_output=True, creationflags=subprocess.CREATE_NO_WINDOW)
                if npm_check.returncode != 0:
                    self.log_status('正在安装http-server...')
                    subprocess.run(
                        ['npx', '--yes', 'http-server@14.1.1', '-g'],
                        creationflags=subprocess.CREATE_NO_WINDOW
                    )
                
                self.log_status('使用Node.js启动服务')
                subprocess.Popen(
                    ['npx', 'http-server', '-p', str(self.port), '-c-1'],
                    cwd=self.root_dir,
                    creationflags=subprocess.CREATE_NO_WINDOW
                )
            
            self.log_status(f'服务已启动：http://localhost:{self.port}')
            messagebox.showinfo('成功', '服务器启动成功')
        except Exception as e:
            messagebox.showerror('错误', f'启动失败：{str(e)}')
        finally:
            self.btn_start.config(state='normal')

if __name__ == '__main__':
    ServerLauncher()