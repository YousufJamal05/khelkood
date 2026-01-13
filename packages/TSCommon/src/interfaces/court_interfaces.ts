/**
 * Interface representing a sports court/facility.
 */
export interface ICourt {
  courtId: string;
  ownerId: string;
  name: string;
  description: string;
  sportType: string;
  area: string;
  address: string;
  location?: string; // Google Maps location link
  pricing: {
    base: number;
    peak?: number;
    weekend?: number;
    [key: string]: number | undefined;
  };
  photos: string[];
  amenities: string[];
  operationalHours: {
    [day: string]: {
      open: string;
      close: string;
    };
  };
  slotDuration: number;
  maxAdvanceBooking: number;
  cancellationPolicy: {
    noticeHours: number;
    refundPercentage: number;
  };
  isVerified: 'pending' | 'approved' | 'rejected';
  rating: number;
  reviewCount: number;
  createdAt: string; // ISO String or human readable string matching user service
}

/**
 * Request payload for adding a new court.
 */
export interface IAddCourtRequest extends Omit<ICourt, 'courtId' | 'isVerified' | 'rating' | 'reviewCount' | 'createdAt'> {
  courtId?: string;
}

/**
 * Request payload for updating an existing court.
 */
export interface IUpdateCourtRequest extends Partial<IAddCourtRequest> {
  courtId: string;
}

/**
 * Request payload for fetching courts with filters.
 */
export interface IGetCourtsRequest {
  ownerId?: string;
  sportType?: string;
  area?: string;
}
