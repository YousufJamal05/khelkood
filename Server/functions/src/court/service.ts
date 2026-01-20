import * as admin from "firebase-admin";
import { Timestamp } from "firebase-admin/firestore";
import { logger } from "firebase-functions";
import { ICourt, IAddCourtRequest, IUpdateCourtRequest, IGetCourtsRequest, CourtStatus, IBlockSlotsRequest } from "@khelkood/common";

export class CourtService {
  private get db() {
    return admin.firestore();
  }
  private collection = "courts";

  /**
   * Adds a new court to Firestore.
   */
  async addCourt(request: IAddCourtRequest): Promise<string> {
    try {
      const { courtId: providedId, ...courtData } = request as any;
      const courtRef = providedId 
        ? this.db.collection(this.collection).doc(providedId)
        : this.db.collection(this.collection).doc();
      const timestamp = Timestamp.now().toDate().toString();

      const newCourt: ICourt = {
        ...courtData,
        courtId: courtRef.id,
        isVerified: CourtStatus.PENDING,
        rating: 0,
        reviewCount: 0,
        createdAt: timestamp,
      };

      await courtRef.set(newCourt);
      logger.info(`Court ${courtRef.id} added successfully.`);
      return courtRef.id;
    } catch (error) {
      logger.error("Error in CourtService.addCourt:", error);
      throw error;
    }
  }

  /**
   * Updates an existing court in Firestore.
   */
  async updateCourt(request: IUpdateCourtRequest): Promise<void> {
    try {
      const { courtId, ...updateData } = request;
      const courtRef = this.db.collection(this.collection).doc(courtId);
      
      const cleanUpdateData = Object.fromEntries(
        Object.entries(updateData).filter(([_, v]) => v !== undefined)
      );

      await courtRef.update(cleanUpdateData);
      logger.info(`Court ${courtId} updated successfully.`);
    } catch (error) {
      logger.error(`Error in CourtService.updateCourt for ${request.courtId}:`, error);
      throw error;
    }
  }

  /**
   * Fetches courts with optional filtering.
   */
  async getCourts(request: IGetCourtsRequest): Promise<ICourt[]> {
    try {
      let query: admin.firestore.Query = this.db.collection(this.collection);

      if (request.ownerId) {
        query = query.where("ownerId", "==", request.ownerId);
      }
      if (request.sportType) {
        query = query.where("sportType", "==", request.sportType);
      }
      if (request.area) {
        query = query.where("area", "==", request.area);
      }

      const snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data() as ICourt);
    } catch (error) {
      logger.error("Error in CourtService.getCourts:", error);
      throw error;
    }
  }

  /**
   * Blocks slots for a court.
   */
  async blockSlots(request: IBlockSlotsRequest): Promise<void> {
    const { courtId, date, slots, reason, additionalNotes } = request;
    const availabilityRef = this.db.collection(this.collection).doc(courtId).collection("availability").doc(date);

    try {
      await this.db.runTransaction(async (transaction) => {
        const doc = await transaction.get(availabilityRef);
        const data = doc.data() || { slots: {} };
        const currentSlots = data.slots || {};

        // Check for conflicts
        for (const slot of slots) {
          if (currentSlots[slot]?.status === "booked") {
            throw new Error(`Slot ${slot} is already booked.`);
          }
        }

        // Update slots
        const updatedSlots = { ...currentSlots };
        for (const slot of slots) {
          updatedSlots[slot] = {
            status: "blocked",
            reason,
            additionalNotes: additionalNotes || "",
            updatedAt: Timestamp.now().toDate().toString(),
          };
        }

        transaction.set(availabilityRef, { slots: updatedSlots }, { merge: true });
      });
      logger.info(`Slots blocked for court ${courtId} on ${date}.`);
    } catch (error) {
      logger.error(`Error in CourtService.blockSlots for ${courtId}:`, error);
      throw error;
    }
  }
}
