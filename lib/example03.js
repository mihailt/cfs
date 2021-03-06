// Generated by CoffeeScript 1.6.1
(function() {
  var SampleApp, app,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  SampleApp = (function(_super) {

    __extends(SampleApp, _super);

    function SampleApp() {
      SampleApp.__super__.constructor.apply(this, arguments);
      this.x = this.width / 2;
      this.y = this.height / 2;
      this.speed = 100;
      this.color = '#FFA318';
    }

    SampleApp.prototype.update = function(dt) {
      if (this.keyboard.pressed.left) {
        this.x -= this.speed * dt;
      }
      if (this.keyboard.pressed.right) {
        this.x += this.speed * dt;
      }
      if (this.keyboard.pressed.up) {
        this.y -= this.speed * dt;
      }
      if (this.keyboard.pressed.down) {
        return this.y += this.speed * dt;
      }
    };

    SampleApp.prototype.draw = function() {
      this.ctx.clearRect(0, 0, this.width, this.height);
      this.ctx.beginPath();
      this.ctx.arc(this.x, this.y, 40 + Math.sin(this.elapsed) * 30, 0, 2 * Math.PI, true);
      this.ctx.closePath();
      this.ctx.fillStyle = this.color;
      return this.ctx.fill();
    };

    return SampleApp;

  })(Splash.App);

  app = new SampleApp('canvas', 800, 600);

  window.onblur = function() {
    return app.stop();
  };

  window.onfocus = function() {
    return app.run();
  };

  app.run();

}).call(this);
