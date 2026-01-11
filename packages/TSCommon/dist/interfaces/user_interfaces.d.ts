import { UserRole, UserStatus } from '../enums/user_enums';
/**
 * Interface representing a user in the system.
 */
export interface IUser {
    uid: string;
    phoneNumber?: string;
    displayName?: string;
    email?: string;
    role: UserRole;
    status: UserStatus;
    profileImageUrl?: string;
    createdAt: number;
    lastLoginAt?: number;
}
/**
 * Request payload for the onboardUser Cloud Function.
 */
export interface IOnboardUserRequest {
    phoneNumber?: string;
    displayName?: string;
    profileImageUrl?: string;
    role?: UserRole;
    email?: string;
}
/**
 * Response for the getUserProfile Cloud Function.
 */
export interface IGetUserProfileResponse {
    user: IUser | null;
}
