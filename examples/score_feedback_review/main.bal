// Reviews the most recent scores of the authenticated user: lists their collaborators and feedback
// comments, and optionally posts a comment on the first score when `postComment` is enabled.

import ballerina/io;
import ballerinax/flatapi;

configurable string flatAccessToken = ?;
configurable boolean postComment = false;
configurable string commentText = "Great work on this arrangement";

public function main() returns error? {
    flatapi:Client flat = check new ({auth: {token: flatAccessToken}});

    flatapi:UserDetails me = check flat->getAuthenticatedUser();
    io:println("Signed in as ", me.username);

    flatapi:ScoreDetails[] scores = check flat->getUserScores(me.id, 'limit = 5);
    if scores.length() == 0 {
        return error("The account has no scores to review");
    }

    foreach flatapi:ScoreDetails score in scores {
        flatapi:ResourceCollaborator[] collaborators = check flat->getScoreCollaborators(score.id);
        flatapi:ScoreComment[] comments = check flat->getScoreComments(score.id);
        io:println(score.title, ": ", collaborators.length(), " collaborator(s), ", comments.length(), " comment(s)");
    }

    if postComment {
        flatapi:ScoreComment added = check flat->addScoreComment(scores[0].id, {comment: commentText});
        io:println("Posted comment ", added.id, " on ", scores[0].title);
    }
}
