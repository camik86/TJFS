class Particle {
  constructor(canvas, ctx) {
    this.canvas = canvas;
    this.ctx = ctx;
    this.reset();
    this.velocity = Math.random() * 0.5 + 0.1;
  }

  reset() {
    this.x = Math.random() * this.canvas.width;
    this.y = Math.random() * this.canvas.height;
    this.radius = Math.random() * 1.5;
    this.alpha = Math.random() * 0.5 + 0.1;
  }

  draw() {
    this.ctx.beginPath();
    this.ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
    this.ctx.fillStyle = `rgba(0, 247, 255, ${this.alpha})`;
    this.ctx.fill();
  }

  update() {
    this.y += this.velocity;
    if (this.y > this.canvas.height) this.reset();
  }
}

class ParticleSystem {
  constructor() {
    this.canvas = document.createElement('canvas');
    this.ctx = this.canvas.getContext('2d');
    this.particles = [];
    this.init();
  }

  init() {
    this.canvas.style.position = 'fixed';
    this.canvas.style.top = 0;
    this.canvas.style.left = 0;
    this.canvas.style.zIndex = -1;
    document.body.prepend(this.canvas);

    window.addEventListener('resize', () => this.resize());
    this.resize();
    
    for (let i = 0; i < 100; i++) {
      this.particles.push(new Particle(this.canvas, this.ctx));
    }

    this.animate();
  }

  resize() {
    this.canvas.width = window.innerWidth;
    this.canvas.height = window.innerHeight;
  }

  animate() {
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    this.particles.forEach(particle => {
      particle.update();
      particle.draw();
    });
    requestAnimationFrame(() => this.animate());
  }
}

// 初始化粒子系统
new ParticleSystem();