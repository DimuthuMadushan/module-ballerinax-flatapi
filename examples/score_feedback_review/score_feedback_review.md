# Score feedback review

This example reads the most recent scores of the authenticated user and reports the collaborators and feedback comments of each. When `postComment` is enabled it also posts a comment on the first score.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Flat access token. See the [setup guide](../../ballerina/README.md#setup-guide).
- Create a `Config.toml` in this directory:
  ```toml
  flatAccessToken = "<your-access-token>"
  postComment = false
  commentText = "Great work on this arrangement"
  ```

## Run the example

```bash
bal run
```
