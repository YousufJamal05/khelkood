/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {setGlobalOptions} from "firebase-functions";
import * as admin from "firebase-admin";

// Initialize Admin SDK once
if (admin.apps.length === 0) {
  admin.initializeApp();
}

setGlobalOptions({ maxInstances: 10 });

import { onboardUser, getUserProfile } from "./user/function";
import { addCourt, updateCourt, getCourts } from "./court/function";

// Export Functions
export { 
  onboardUser, 
  getUserProfile,
  addCourt,
  updateCourt,
  getCourts
};
