import { HttpsError } from "firebase-functions/v2/https";
import { IAddCourtRequest, IUpdateCourtRequest, IBlockSlotsRequest } from "@khelkood/common";

export class CourtValidator {
  /**
   * Validates the add court request.
   */
  static validateAddCourt(data: any): IAddCourtRequest {
    if (!data.name || !data.sportTypes || !Array.isArray(data.sportTypes) || data.sportTypes.length === 0 || !data.area || !data.address) {
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
      sportTypes: data.sportTypes,
      area: data.area,
      address: data.address,
      location: data.location,
      pricing: data.pricing || { base: 0 },
      photos: data.photos,
      amenities: data.amenities || [],
      operationalHours: data.operationalHours || {},

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
      sportTypes: data.sportTypes,
      area: data.area,
      address: data.address,
      location: data.location,
      pricing: data.pricing,
      photos: data.photos,
      amenities: data.amenities,
      operationalHours: data.operationalHours,

      maxAdvanceBooking: data.maxAdvanceBooking,
      cancellationPolicy: data.cancellationPolicy,
    };
  }

  /**
   * Validates the block slots request.
   */
  static validateBlockSlots(data: any): IBlockSlotsRequest {
    if (!data.courtId || !data.date || !data.slots || !Array.isArray(data.slots) || data.slots.length === 0 || !data.reason) {
      throw new HttpsError("invalid-argument", "Missing required block slots fields.");
    }

    return {
      courtId: data.courtId,
      date: data.date,
      slots: data.slots,
      reason: data.reason,
      additionalNotes: data.additionalNotes,
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
