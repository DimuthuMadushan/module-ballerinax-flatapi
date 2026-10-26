# Running Tests

## Prerequisites

The tests run against a mock Flat API server by default, so no credentials are needed.

To run them against the live Flat API, set these environment variables:

| Variable | Description |
|---|---|
| `IS_LIVE_SERVER` | Set to `true` to call `https://api.flat.io/v2` instead of the mock server |
| `FLAT_ACCESS_TOKEN` | An access token with the scopes needed by the tests |
| `FLAT_SCORE_ID` | The ID of a score the token can read and edit |
| `FLAT_USER_ID` | The ID of the authenticated user |

## Running the tests

Navigate to the `ballerina` directory and execute:

```bash
bal test
```

To run only the mock tests or the live tests:

```bash
bal test --groups mock_tests
bal test --groups live_tests
```

## Test coverage

The suite covers the user, score, collection, class, assignment, group, organization user and task operations, including creating, reading, updating and deleting scores and collections, and adding comments to a score.
