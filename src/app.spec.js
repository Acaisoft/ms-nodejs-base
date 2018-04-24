const request = require("supertest");
const app = require("./app");

describe("app", () => {
  describe("endpoint: /", () => {
    describe("GET", () => {
      it("should respond with 200", async () => {
        const response = await request(app).get("/");
        expect(response.statusCode).toBe(200);
      });

      it("should respond with a text message", async () => {
        const response = await request(app).get("/");

        expect(response.text).toBe("Hello World!");
        expect(response.header["content-type"]).toBe(
          "text/html; charset=utf-8"
        );
      });
    });
  });
  describe("endpoint: /healthz", () => {
    describe("GET", () => {
      it("should respond with 200", async () => {
        const response = await request(app).get("/healthz");
        expect(response.statusCode).toBe(200);
      });

      it("should respond with a text message", async () => {
        const response = await request(app).get("/healthz");

        expect(response.body).toMatchObject({ status: "OK" });
        expect(response.header["content-type"]).toBe(
          "application/json; charset=utf-8"
        );
      });
    });
  });
});
