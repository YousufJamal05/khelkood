import { onCall, HttpsError } from "firebase-functions/v2/https";
import { UserService } from "./service";
import { UserValidator } from "./validator";
import { IGetUserProfileResponse } from "@khelkood/common";

const userService = new UserService();

/**
 * Onboards a user.
 */
export const onboardUser = onCall<any>(async (request) => {
  const uid = UserValidator.checkAuth(request.auth);
  const validatedData = UserValidator.validateOnboardUser(request.data);
  const authPhoneNumber = request.auth?.token.phone_number;

  try {
    await userService.onboardUser(uid, validatedData, authPhoneNumber);
    return { success: true };
  } catch (error) {
    throw new HttpsError("internal", "Failed to onboard user.");
  }
});

/**
 * Gets a user profile.
 */
export const getUserProfile = onCall<any, Promise<IGetUserProfileResponse>>(async (request) => {
  const uid = UserValidator.checkAuth(request.auth);

  try {
    const user = await userService.getUser(uid);
    return { user };
  } catch (error) {
    throw new HttpsError("internal", "Failed to fetch user profile.");
  }
});
