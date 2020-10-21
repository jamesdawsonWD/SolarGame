import { StarPosition } from './types';
export interface RootState {
    version: string;
}

export interface Network {
    coinbase: string;
    networkData: NetworkData;
    coinbaseReady: boolean;
    web3Ready: boolean;
    web3: any;
    contracts: {
        solar: any;
        fhr: any;
        sat: any;
        gameOperations: any;
        gameStorage: any;
        treasury: any;
        planets: { [key: string]: any };
    };
    ethReady: boolean;
    userAddress: string;
    sentTransactions: {};
}

export interface NetworkData {
    currentBlock: number;
    network: string;
    networkId: number;
}

export interface SatInfo {
    offense: number;
    defense: number;
}

export interface Sat {
    id: number;
    balance: number;
}

export interface SatsInfo {
    [key: number]: SatInfo;
}
export interface StarInfo {
    systemType: number;
}
export interface GameStorageOperations {
    currentStarLocation: StarPosition | null;
    satsInfo: SatsInfo;
    starsInfo: {
        [key: string]: StarInfo;
    };
    planetsToTokenId: {
        [key: string]: number;
    };
    tokenIdToPlanet: {
        [key: number]: string;
    };
    boundaries: StarPosition;
}

export interface StarPosition {
    quadrant: number;
    sector: number;
    district: number;
    star: number;
}
export interface GameOperations { }
export interface TreasuryOperations { }
export interface SolarOperations {
    balance: number;
}

export interface PlanetInfo {
    yield: number;
    balance: number;
    sats: { [key: number]: Sat };
    dateLocked: Date;
    tokenId: number;
    minHold: number;
}
export interface Planets {
    [key: string]: PlanetInfo;
}

export interface FhrOperations {
    balance: number[];
    treasuryApproved: boolean;
}

export interface SatOperations {
    balances: {
        [key: number]: number;
    };
    treasuryApproved: boolean;
}
export interface Deposit {
    amount: number;
    length: number;
}

export interface UserInterfaceManager {
    isLoading: boolean;
    modal: Modal;
    error: Error;
    success: {
        msg: string;
    };
    localStarPosition: StarPosition;
}

export interface Modal {
    show: boolean;
    content: string;
    data: {
        [key: string]: string | boolean | number;
    };
}
