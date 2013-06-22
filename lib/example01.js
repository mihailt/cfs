// Generated by CoffeeScript 1.6.1
(function() {
  var Particle, SampleApp, app,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Particle = (function() {

    function Particle(x, y, vx, vy) {
      this.x = x;
      this.y = y;
      this.vx = vx;
      this.vy = vy;
      this.scale = 1.0;
      this.radius = 20;
      this.color = '#ff0000';
      this.scaleSpeed = 0.2;
    }

    Particle.prototype.update = function(dt) {
      this.scale -= this.scaleSpeed * dt;
      if (this.scale <= 0) {
        this.scale = 0;
      }
      this.x += this.vx * dt;
      return this.y += this.vy * dt;
    };

    Particle.prototype.draw = function(ctx) {
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.radius * this.scale, 0, 2 * Math.PI, true);
      ctx.closePath();
      ctx.fillStyle = this.color;
      ctx.fill();
      ctx.strokeStyle = '#fff';
      ctx.stroke();
      return ctx.restore();
    };

    return Particle;

  })();

  SampleApp = (function(_super) {

    __extends(SampleApp, _super);

    function SampleApp() {
      SampleApp.__super__.constructor.apply(this, arguments);
      this.particles = [];
      this.paused = false;
    }

    SampleApp.prototype.update = function(dt) {
      var angle, p, particle, speed, vx, vy, _i, _j, _len, _ref, _ref1;
      if (this.keyboard.released.P) {
        this.paused = !this.paused;
      }
      if (this.mouse.down.left) {
        speed = 10;
        for (angle = _i = 0, _ref = Math.round(360 / 10); _i < 360; angle = _i += _ref) {
          vx = speed * Math.cos(angle * Math.PI / 180);
          vy = speed * Math.sin(angle * Math.PI / 180);
          particle = new Particle(this.mouse.x, this.mouse.y, vx, vy);
          this.particles.push(particle);
        }
      }
      if (this.paused) {
        return;
      }
      _ref1 = this.particles;
      for (_j = 0, _len = _ref1.length; _j < _len; _j++) {
        p = _ref1[_j];
        p.update(dt);
      }
      return this.particles = this.particles.filter(function(p) {
        return p.scale > 0;
      });
    };

    SampleApp.prototype.draw = function() {
      var p, _i, _len, _ref, _results;
      this.ctx.clearRect(0, 0, this.width, this.height);
      _ref = this.particles;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        p = _ref[_i];
        _results.push(p.draw(this.ctx));
      }
      return _results;
    };

    return SampleApp;

  })(Splash.App);

  app = new SampleApp('canvas', 800, 600);

  app.run();

}).call(this);