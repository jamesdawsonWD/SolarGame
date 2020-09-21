export interface RootState {
    version: string;
}

export interface Network {
    coinbase: string;
    networkData: NetworkData;
    coinbaseReady: boolean;
    web3Ready: boolean;
    web3: any;
    master: any;
    tsuno: any;
    ethReady: boolean;
    userAddress: string;
    sentTransactions: {};
}

export interface NetworkData {
    currentBlock: number;
    network: string;
    networkId: number;
}

export interface FundOperations {
    balance: number;
    stakedTime: number;
    dateUnlocked: Date;
}

export interface GameOperations {
    soldiers: number;
    cavalry: number;
    siegeWeapons: number;
    defenseStructures: number;
    totalArmyHealth: number;
}

export interface TsunoOperations {
    balance: number;
}

export interface Deposit {
    amount: number;
    length: number;
}

export interface UserInterfaceManager {
    isLoading: boolean;
    modal: Modal;
    error: Error;
}

export interface Modal {
    show: boolean;
    content: string;
    data: {
        [key: string]: string | boolean | number;
    };
}
