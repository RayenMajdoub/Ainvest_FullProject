class appError extends Error {
    constructor(message, code) {
      super(message);
      this.code = code;
      Error.captureStackTrace(this, this.constructor);
    }
  
    toJson() {
      return {
        code: this.code,
        message: this.message,
      };
    }
  }
module.exports = appError;
