import * as admin from "firebase-admin";
import { Timestamp } from "firebase-admin/firestore";
import { logger } from "firebase-functions";
import { IUser, IOnboardUserRequest, UserRole, UserStatus } from "@khelkood/common";

export class UserService {
  private get db() {
    return admin.firestore();
  }
  private collection = "users";

  /**
   * Fetches a user profile from Firestore.
   */
  async getUser(uid: string): Promise<IUser | null> {
    try {
      const userSnap = await this.db.collection(this.collection).doc(uid).get();
      if (!userSnap.exists) return null;

      const data = userSnap.data();
      return {
        uid: uid,
        phoneNumber: data?.phoneNumber,
        displayName: data?.displayName,
        email: data?.email,
        role: data?.role,
        status: data?.status,
        profileImageUrl: data?.profileImageUrl,
        createdAt: data?.createdAt,
        lastLoginAt: data?.lastLoginAt,
      } as IUser;
    } catch (error) {
      logger.error(`Error in UserService.getUser for ${uid}:`, error);
      throw error;
    }
  }

  /**
   * Onboards or updates a user profile.
   */
  async onboardUser(uid: string, request: IOnboardUserRequest, authPhoneNumber?: string): Promise<void> {
    try {
      const userRef = this.db.collection(this.collection).doc(uid);
      const userSnap = await userRef.get();

      // IMPORTANT: Using Date().toString() via Timestamp package as requested
      const timestamp = Timestamp.now().toDate().toString();

      if (!userSnap.exists) {
        // First time onboarding
        await userRef.set({
          uid: uid,
          phoneNumber: request.phoneNumber || authPhoneNumber || "",
          displayName: request.displayName || "",
          profileImageUrl: request.profileImageUrl || "",
          role: request.role || UserRole.PLAYER,
          status: UserStatus.ACTIVE,
          createdAt: timestamp,
          lastLoginAt: timestamp,
        });
        logger.info(`User ${uid} onboarded successfully with string dates.`);
      } else {
        // Update existing profile
        await userRef.update({
          phoneNumber: request.phoneNumber || userSnap.data()?.phoneNumber || authPhoneNumber,
          displayName: request.displayName || userSnap.data()?.displayName,
          profileImageUrl: request.profileImageUrl || userSnap.data()?.profileImageUrl,
          lastLoginAt: timestamp,
        });
        logger.info(`User ${uid} profile updated with string dates.`);
      }
    } catch (error) {
      logger.error(`Error in UserService.onboardUser for ${uid}:`, error);
      throw error;
    }
  }
}
