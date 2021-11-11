import Vue from 'vue'
import Router from 'vue-router'

const routes = [
    {
        path: '/:id', 
        name: 'App',  
        transition: 'fade',
        component: () => import('@/views/App.vue'),
        children: [
            {
                path: 'setup',
                name: 'Setup',
                transition: 'fade',
                component: () => import('@/views/Setup/App.vue'),
            },
            {
                path: 'questions',
                name: 'Questions',
                transition: 'fade',
                component: () => import('@/views/Questions/App.vue'),
            },
            {
                path: '*',
                name: 'Activate',
                transition: 'fade',
                component: () => import('@/views/Activate/App.vue'),
            }
        ]
    },
]

const router = new Router({
    mode: 'history',
    base: '/',
    routes
})

Vue.use(Router)

export default router