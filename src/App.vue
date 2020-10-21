<template>
    <div id="app">
        <div id="nav">
            <router-link to="/">Map</router-link> |
            <router-link to="/fleetManager">Fleet</router-link> |
            <router-link to="/market">Market</router-link>
        </div>
        <router-view />
    </div>
</template>
<script lang="ts">
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
// import Modal from '@/components/generics/Modal.vue';
// import Button from '@/components/generics/Button.vue';
export default {
    name: 'App',
    computed: {
        // ...mapGetters([
        //     'Address',
        //     'Balance',
        //     'TsunoBalance',
        //     'ShowModal',
        //     'DateUnlocked',
        //     'RecentError'
        // ])
    },
    components: {
        // DepositForm,
        // Modal,
        // Button
    },
    methods: {
        ...mapActions(['bootstrapContracts', 'GS_retrieveBoundaries'])
        // depositAmount: function(deposit: Deposit) {
        //     this.deposit(deposit);
        // }
    },

    async mounted() {
        await this.bootstrapContracts();
        await this.GS_retrieveBoundaries();

        // await this.getBalance();
        // await this.getTsunoBalance();
        // await this.getDateUnlocked();
    }
};
</script>
<style lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@700&display=swap');
#app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    overflow: hidden;
    color: #2c3e50;
    height: 100vh;
    background: #020c3d;
}

#nav {
    padding: 30px;
    a {
        font-weight: bold;
        color: #2c3e50;

        &.router-link-exact-active {
            color: #42b983;
        }
    }
}

/* http://meyerweb.com/eric/tools/css/reset/
   v2.0 | 20110126
   License: none (public domain)
*/

html,
body,
div,
span,
applet,
object,
iframe,
h1,
h2,
h3,
h4,
h5,
h6,
p,
blockquote,
pre,
a,
abbr,
acronym,
address,
big,
cite,
code,
del,
dfn,
em,
img,
ins,
kbd,
q,
s,
samp,
small,
strike,
strong,
sub,
sup,
tt,
var,
b,
u,
i,
center,
dl,
dt,
dd,
ol,
ul,
li,
fieldset,
form,
label,
legend,
table,
caption,
tbody,
tfoot,
thead,
tr,
th,
td,
article,
aside,
canvas,
details,
embed,
figure,
figcaption,
footer,
header,
hgroup,
menu,
nav,
output,
ruby,
section,
summary,
time,
mark,
audio,
video {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article,
aside,
details,
figcaption,
figure,
footer,
header,
hgroup,
menu,
nav,
section {
    display: block;
}
body {
    line-height: 1;
}
ol,
ul {
    list-style: none;
}
blockquote,
q {
    quotes: none;
}
blockquote:before,
blockquote:after,
q:before,
q:after {
    content: '';
    content: none;
}
table {
    border-collapse: collapse;
    border-spacing: 0;
}

h1,
h2,
h3,
h4,
h5 {
    font-family: 'Ubuntu', sans-serif;
}
</style>
