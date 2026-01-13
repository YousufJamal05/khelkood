import { onCall, HttpsError } from "firebase-functions/v2/https";
import { CourtService } from "./service";
import { CourtValidator } from "./validator";
import { ICourt } from "@khelkood/common";

const courtService = new CourtService();

/**
 * Adds a new court.
 */
export const addCourt = onCall<any, Promise<{ courtId: string }>>(async (request) => {
  CourtValidator.checkAuth(request.auth);
  const validatedData = CourtValidator.validateAddCourt(request.data);

  try {
    const courtId = await courtService.addCourt(validatedData);
    return { courtId };
  } catch (error) {
    if (error instanceof HttpsError) throw error;
    throw new HttpsError("internal", "Failed to add court.");
  }
});

/**
 * Updates an existing court.
 */
export const updateCourt = onCall<any, Promise<{ success: boolean }>>(async (request) => {
  CourtValidator.checkAuth(request.auth);
  const validatedData = CourtValidator.validateUpdateCourt(request.data);

  try {
    await courtService.updateCourt(validatedData);
    return { success: true };
  } catch (error) {
    if (error instanceof HttpsError) throw error;
    throw new HttpsError("internal", "Failed to update court.");
  }
});

/**
 * Gets courts based on filters.
 */
export const getCourts = onCall<any, Promise<ICourt[]>>(async (request) => {
  CourtValidator.checkAuth(request.auth);
  
  try {
    const courts = await courtService.getCourts(request.data || {});
    return courts;
  } catch (error) {
    throw new HttpsError("internal", "Failed to fetch courts.");
  }
});
