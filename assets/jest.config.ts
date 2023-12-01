/** @type {import('ts-jest').JestConfigWithTsJest} */
module.exports = {
  preset: "ts-jest",
  setupFiles: ["./jest.polyfills.js"],
  setupFilesAfterEnv: ["./jest.setup.ts"],
  testEnvironmentOptions: {
    customExportConditions: [""],
  },
  testEnvironment: "jsdom",
};
