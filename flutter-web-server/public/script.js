var app = new Vue({
    el: '#app',
    data: {
        projects: [{ 'project': 'project-a', 'author': 'unknown', 'github': 'https://github.com/grollcake/DanceWithFlutter' }],
        selected: {},
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
        },
        showDetail: function (project) {
            this.selected = project;
            var myModal = new bootstrap.Modal(document.getElementById('detailView'), {});
            myModal.show();
        },
    }
});
