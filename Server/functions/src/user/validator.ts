import { HttpsError } from "firebase-functions/v2/https";
import { IOnboardUserRequest } from "@khelkood/common";

export class UserValidator {
  /**
   * Validates the onboarding request.
   */
  static validateOnboardUser(data: any): IOnboardUserRequest {
    // We allow optional fields for onboarding (displayName, profileImageUrl, role, phoneNumber)
    // but we can add specific checks if needed.
    return {
      displayName: data.displayName,
      profileImageUrl: data.profileImageUrl,
      role: data.role,
      phoneNumber: data.phoneNumber,
      email: data.email,
    };
  }

  /**
   * Validates that the user is authenticated.
   */
  static checkAuth(auth: any): string {
    if (!auth) {
      throw new HttpsError(
        "unauthenticated",
        "The function must be called while authenticated."
      );
    }
    return auth.uid;
  }
}
