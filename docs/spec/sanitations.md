_Author_:  @DimuthuMadushan \
_Created_: 2026/10/26 \
_Updated_: 2026/10/26 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Flat. 
The OpenAPI specification is obtained from at [https://github.com/wso2/api-specs/blob/main/openapi/flat/flat/2.26.2/openapi.yaml](https://github.com/wso2/api-specs/blob/main/openapi/flat/flat/2.26.2/openapi.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. **OpenAPI version changed from 3.1.0 to 3.0.3.** `bal openapi flatten` drops the `type` of most schema properties and schemas when the document declares OpenAPI 3.1.0, which turns them into untyped fields. The document uses no other 3.1-only construct, so it is declared as 3.0.3. Made in the original spec (`openapi`).

2. **Type arrays replaced by `nullable`.** The 41 occurrences of `type: [<type>, 'null']` (for example `AssignmentUpdate.maxPoints`, `ScoreModification.composer`, `UserCommunityProfileLinks.websiteUrl`, `ClassGroupIdsToApplyToAssignment`, `ScoreLicense`) are now `type: <type>` with `nullable: true`, because OpenAPI 3.0 has no type arrays. Made in the original spec.

3. **`info.description` rewritten.** The description was a long Markdown text with links and lists. It is now a short plain-text summary of what the connector does, which becomes the `Client` class documentation. Made in the original spec.

4. **Missing descriptions added.** Descriptions were added to the properties and the query parameter that had none: `OmrPendingStep.data`, `EduResource.resource`, `ScoreTrack`, `ScoreTrackCreation` and `ScoreTrackUpdate` `.synchronizationPoints`, `ScoreCommentContext` `.startTimePos`, `.stopTimePos`, `.startDpq` and `.stopDpq`, `AssignmentSubmission` `.attachments`, `.comments`, `.playback` and `.microsoftGraph`, `AssignmentSubmissionUpdate` `.attachments` and `.playback`, `AssignmentSubmissionHistory.attachment`, `ClassDetails.microsoftGraph`, `ScoreRevision.collaborators`, `OmrDetailsStepData.instruments`, `UserDetails.azureDetails`, and the required `type` query parameter of the group listing. The two bare `$ref` properties (`AssignmentSubmission.microsoftGraph`, `UserDetails.azureDetails`) are wrapped as `allOf` with a `description`. This removes every `undocumented field` warning. Made in the original spec.

5. **Binary download responses narrowed to `application/octet-stream`.** The 200 responses of `GET /scores/{score}/revisions/{revision}/{format}` (which listed nine media types), `GET /classes/{class}/assignments/{assignment}/submissions/csv`, `.../submissions/excel` and `GET /omr/jobs/{job}/files/{index}` declared specific binary media types, which generate `record {byte[] fileContent; string fileName;}` or `http:Response` returns. They now declare only `application/octet-stream` so the client returns `byte[]`. Made in the original spec.

6. **Operation renames (kept in `ai-mappings.json`).** `postSubmissionComment` is `addSubmissionComment`, `postScoreComment` is `addScoreComment` (no HTTP-verb names), and `countOrgaUsers` is `countOrganizationUsers`.

7. **Schema renames (kept in `ai-mappings.json`).** The generated `GroupsgroupBody` is `RenameGroupRequest`, `GroupUsersBody` is `AddGroupUserRequest` and `InlineResponse200` is `AddGroupUserResponse`.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --license docs/license.txt -o ballerina --client-methods remote
```

Note: The license year is hardcoded to 2026, change if necessary.
