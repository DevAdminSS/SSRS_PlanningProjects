using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PlanningProjects.Startup))]
namespace PlanningProjects
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
