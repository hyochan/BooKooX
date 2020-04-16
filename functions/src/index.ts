import * as functions from 'firebase-functions';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const privacyPolicy = functions.https.onRequest((_, response) => {
  response.redirect(
    'https://dooboolab.com/privacyandpolicy',
  );
});

export const termsOfService = functions.https.onRequest((_, response) => {
  response.redirect(
    'https://dooboolab.com/termsofservice',
  );
});
