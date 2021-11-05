var app = new Vue({
    el: '#app',
    data: {
        message: '안녕하세요 Vue!',
        projects: ["project-a", "project-b"]
    },
    mounted: function () {
        this.getProjectsList()
    },
    methods: {
        getProjectsList: function () {
            axios.get("/projects.json").then((response) => {
                console.log(response.data);
                this.projects = response.data;
            })
        }
    }
});
