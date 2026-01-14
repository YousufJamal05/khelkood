import { HttpsError } from "firebase-functions/v2/https";
import { IAddCourtRequest, IUpdateCourtRequest } from "@khelkood/common";

export class CourtValidator {
  /**
   * Validates the add court request.
   */
  static validateAddCourt(data: any): IAddCourtRequest {
    if (!data.name || !data.sportType || !data.area || !data.address) {
      throw new HttpsError("invalid-argument", "Missing required court fields.");
    }

    if (!data.photos || !Array.isArray(data.photos) || data.photos.length < 1 || data.photos.length > 3) {
      throw new HttpsError("invalid-argument", "Court must have between 1 and 3 photos.");
    }

    return {
      courtId: data.courtId,
      ownerId: data.ownerId,
      name: data.name,
      description: data.description || "",
      sportType: data.sportType,
      area: data.area,
      address: data.address,
      location: data.location,
      pricing: data.pricing || { base: 0 },
      photos: data.photos,
      amenities: data.amenities || [],
      operationalHours: data.operationalHours || {},
      slotDuration: data.slotDuration || 60,
      maxAdvanceBooking: data.maxAdvanceBooking || 30,
      cancellationPolicy: data.cancellationPolicy || { noticeHours: 24, refundPercentage: 50 },
    };
  }

  /**
   * Validates the update court request.
   */
  static validateUpdateCourt(data: any): IUpdateCourtRequest {
    if (!data.courtId) {
      throw new HttpsError("invalid-argument", "Missing courtId for update.");
    }

    if (data.photos && (!Array.isArray(data.photos) || data.photos.length < 1 || data.photos.length > 3)) {
      throw new HttpsError("invalid-argument", "Court must have between 1 and 3 photos.");
    }

    return {
      courtId: data.courtId,
      name: data.name,
      description: data.description,
      sportType: data.sportType,
      area: data.area,
      address: data.address,
      location: data.location,
      pricing: data.pricing,
      photos: data.photos,
      amenities: data.amenities,
      operationalHours: data.operationalHours,
      slotDuration: data.slotDuration,
      maxAdvanceBooking: data.maxAdvanceBooking,
      cancellationPolicy: data.cancellationPolicy,
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
