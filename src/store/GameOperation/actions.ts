import { getTxEventParams, SYSTEM_TYPES_IDS } from '@/utils/index';
import { ActionTree, ActionContext } from 'vuex';
import { RootState, GameOperations, StarPosition, TxResult } from './../types';
export const actions: ActionTree<GameOperations, RootState> = {
    async GO_move(context: ActionContext<GameOperations, RootState>, payload: StarPosition) {
        const { GameOperations, Address } = context.getters;
        const posP = [payload.quadrant, payload.sector, payload.district, payload.star];
        console.log(posP);
        GameOperations.methods
            .move(posP)
            .send({ from: Address })
            .then((tx: TxResult) => {
                const event = getTxEventParams(tx, ['LogStarSystemDiscovery'], [['systemType']]);
                const systemType: number = event.LogStarSystemDiscovery.systemType;
                context.dispatch('GS_setStarSystemType', { pos: payload, systemType });
                switch (SYSTEM_TYPES_IDS[systemType]) {
                    case 'AncientFleetAggressive':
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'You have been attacked!',
                            message:
                                'An all powerful, almost God like ancient Fleet attacked you. I am not going to lie, this did not turn out well for you.'
                        });
                        console.log('Ancient Aggressive FLeet');
                        break;
                    case 'SuperComputerEvent':
                        console.log('Super Computer Event');
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'The meaning of life: 42',
                            message: 'Well you only wanted the anwser. You have recieved 42 solar.'
                        });
                        break;
                    case 'AdvancedAlienFleetAggressiv':
                        console.log('Advanced Alien Fleet Attack');
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'You were attacked!',
                            message:
                                'An angry advanced alien race. The have done the damage and have warped out again. Could of sworn I saw someone flip us off as they went...'
                        });
                        break;
                    case 'AiFleetAggressiv':
                        console.log('Ai Fleet Attack');
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'You have been attacked!',
                            message: 'Beep boop. An artifical intelligense attacked you! Give us your Solar.'
                        });
                        break;
                    case 'AlienFleetAggressiv':
                        console.log('Alien Fleet Attack');
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'You have been attacked!',
                            message: 'An average alien fleet. They are not much of a threat.'
                        });
                        break;
                    case 'PiratesEven':
                        console.log('Pirate Attack');
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'ARRRRHHHHHHGG!',
                            message: 'You have been attacked by pirates!'
                        });
                        break;
                    case 'Empty':
                        console.log('It is empty here.');
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'It is empty here.',
                            message: 'Just like 99.9999999% of it.'
                        });
                        break;

                    case 'LowYieldSystem':
                        console.log('');
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'You discovered a new planet!',
                            message: 'A dusty old planet but I think you can still get some mining done!'
                        });
                        break;

                    case 'MediumYieldSystem':
                        console.log(
                            'You discovered a good size planet, I can see some money to be made down there.'
                        );
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'You discovered a new planet!',
                            message:
                                'You discovered a good size planet, I can see some money to be made down there.'
                        });
                        break;

                    case 'HighYieldSystem':
                        console.log(
                            'You discovered a highly resourcful Planet. This is going to very profitable.'
                        );
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'You discovered a new planet!',
                            message: 'A highly resourcful Planet. This is going to very profitable.'
                        });
                        break;
                    case 'InsaneYieldSystem':
                        console.log('You discovered a insanly rare Planet. The resources are insane!');
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'You discovered a new planet!',
                            message: 'A insanly rare Planet. The resources are insane!'
                        });
                        break;
                    default:
                        context.dispatch('UIM_setPlanetDiscoveredUi', {
                            header: 'This event is not ready yet!',
                            message: 'Soon my young padawan, soon...'
                        });
                        break;
                }
            })
            .catch((err: Error) => context.dispatch('setError', err));
    },
    async GO_attack(
        context: ActionContext<GameOperations, RootState>,
        payload: { defender: string; turns: number }
    ) {
        const { GameOperations, Address } = context.getters;
        GameOperations.methods
            .attack(payload.defender, payload.turns)
            .send({ from: Address })
            .then((tx: any) => {
                console.log(tx);
            })
            .catch((err: Error) => context.dispatch('setError', err));
    },
    async GO_deployPlanet(context: ActionContext<GameOperations, RootState>, payload: { tokenId: number }) {
        const { GameOperations, Address } = context.getters;
        GameOperations.methods
            .deployPlanet(payload.tokenId)
            .send({ from: Address, gas: 4000000 })
            .then((tx: any) => {
                console.log(tx);
                const event = getTxEventParams(tx, ['LogPlanetProxyCreated'], [['proxy']]);
                const proxy: string = event.LogPlanetProxyCreated.proxy;
                context
                    .dispatch('NETWORK_setupPlanet', proxy)
                    .then(() => context.dispatch('PLANET_retrieveDetails', { planet: proxy }))
                    .then(() => new Promise(resolve => setTimeout(() => resolve(), 2500)))
                    .then(() =>
                        context.dispatch('UIM_openModal', {
                            show: true,
                            type: 'planet',
                            content: 'Your planet has been deployed!',
                            data: {
                                tokenId: payload.tokenId,
                                proxyAddress: proxy
                            }
                        })
                    );
            })
            .catch((err: Error) => context.dispatch('setError', err));
    },
    async GO_testFhrDiscovery(
        context: ActionContext<GameOperations, RootState>,
        payload: { systemType: number }
    ) {
        const { GameOperations, Address } = context.getters;
        GameOperations.methods
            .testFhrDiscovery(payload.systemType)
            .send({ from: Address })
            .then((tx: any) => {
                console.log(tx);
            })
            .catch((err: Error) => context.dispatch('setError', err));
    }
};
