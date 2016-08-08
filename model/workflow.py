from drain import step, model, util
from epa.model.transform import EpaTransform
import logging
from itertools import product

violation_state_args = dict(
    outcome_expr='aux.violation_state',
    train_query='aux.evaluation_state', 
    evaluation=False
)

violation_args = dict(
    outcome_expr='aux.violation_epa',
    train_query='aux.evaluation_epa', 
    evaluation=False
)

region_4_violation_types = [
        '262.A',
        # 264.*
        '264.A', '264.AA', '264.B', '264.BB', '264.C', '264.CC', '264.D', '264.DD', '264.E', '264.EE', '264.F', '264.G', '264.H', '264.I', '264.J', '264.K', '264.L', '264.M', '264.N', '264.O', '264.S', '264.W', '264.X', 
        # 268.*
        '268.A', '268.B', '268.C', '268.D', '268.E', 
        # 270.*
        '270.A', '270.B', '270.C', '270.D', '270.F', '270.G', '270.H', '270.I', 
        '265.J', '265.BB', '265.CC'
]

# use where() so that it's null when not evaluated by epa
region_4_outcome_expr = "aux.violation_types_epa.apply(lambda v, vt=set([%s]): not vt.isdisjoint(v)).where(aux.evaluation_epa)" % \
        str.join(',', ["'%s'" % v for v in region_4_violation_types])

region_4_args = dict(
    outcome_expr=region_4_outcome_expr,
    train_query='aux.evaluation_epa',
    region=4,
    evaluation=False)

evaluation_args = dict(
    outcome_expr='aux.evaluation_epa', 
    train_query=['aux.active_today | aux.evaluation | (aux.handler_age < 365) | aux.br',
            #'(active_today or evaluation or (handler_age < 365)) and br'
            ], 
    evaluation=True
)

forest = {'__class_name__':['sklearn.ensemble.RandomForestClassifier'], 
        'n_estimators':[500],
        'criterion':['entropy'],
        #'balanced':[True],
        'max_features':['sqrt'],
        'n_jobs':[-1]}

logit = {'__class_name__':['sklearn.linear_model.LogisticRegression'],
        'penalty':['l1'], 'C':[0.1]}

adaboost = {'__class_name__':['sklearn.ensemble.AdaBoostClassifier'],
            'n_estimators':[25],
            'learning_rate':[1]}

gradient= {'__class_name__':['sklearn.ensemble.GradientBoostingClassifier'],
            'loss':['deviance'],
            'learning_rate':[0.1],
            'n_estimators':[100],
            'max_depth':[3]}

svm = {'__class_name__':['sklearn.svm.LinearSVC'],
        'C':[.01], 'penalty':['l1'], 'dual':[False]}

forest_search = {'__class_name__':['sklearn.ensemble.RandomForestClassifier'], 
        'n_estimators':[500],
        'criterion': ['entropy', 'gini'],
        'max_features':['sqrt','log2'],
        'n_jobs':[-1]}

logit_search = {'__class_name__':['sklearn.linear_model.LogisticRegression'],
        'penalty':['l1','l2'], 'C':[.01,.1,1,10]}

adaboost_search = {'__class_name__':['sklearn.ensemble.AdaBoostClassifier'],
            'n_estimators':[20,30,50]}

svm_search = [{'__class_name__':['sklearn.svm.LinearSVC'],
        'C':[.01,.1,1], 'penalty':['l2'], 'dual':[True,False]},
        {'__class_name__':['sklearn.svm.LinearSVC'],
        'C':[.01,.1,1], 'penalty':['l1'], 'dual':[False]}]

### Newly created workflows for NYSDEC project
def violation_state_original_data():
    return models(transform_search= dict(train_years=range(2,6), year=range(2012,2016),exclude =[['manifest_.*','br_.*']], **violation_state_args), estimator_search=forest)

def violation_state_manifest_added():
    return models(transform_search= dict(train_years=range(2,6), year=range(2012,2016),exclude=[['br_.*']], **violation_state_args), estimator_search=forest)

def violation_state_br_added():
    return models(transform_search= dict(train_years=range(2,6), year=range(2012,2016), exclude=[['manifest_.*']], **violation_state_args), estimator_search=forest)

def violation_state_manifest_br_added():
    return models(transform_search= dict(train_years=range(2,6), year=range(2013,2016), **violation_state_args), estimator_search=forest)



### Old workflows

def violation():
    return models(transform_search= dict(train_years=2, **violation_args), estimator_search=forest)

def violation_region_4():
    return models(transform_search= dict(train_years=5, **region_4_args), estimator_search=forest)

def violation_region2_nysdec():
	return models(transform_search=dict(region=2,train_years=5, **violation_args),
            estimator_search=forest)

def violation_fast():
    return models(transform_search= dict(train_years=1, year=2016, **violation_args), estimator_search=forest)

def violation_state():
    return models(transform_search= dict(train_years=range(2,4), year=[2013,2015], **violation_state_args), estimator_search=forest)

def violation_state_adaboost():
    return models(transform_search= dict(train_years=range(2,4), year=[2013,2015], **violation_state_args), estimator_search=adaboost)

def violation_state_logistic():
    return models(transform_search= dict(train_years=range(2,4), year=[2013,2015], **violation_state_args), estimator_search=logit)

def violation_best():
    return models(transform_search= dict(train_years=2, **violation_args), estimator_search=forest) + \
            models(transform_search=violation_args, estimator_search=logit)
            #models(transform_search= violation_args, estimator_search=svm)

def violation_train_years():
    return models(transform_search=dict(train_years=range(1,6), **violation_args),
            estimator_search=forest)

def violation_region():
    return models(transform_search=dict(region=range(1,11),train_years=5, **violation_args), 
            estimator_search=forest)

def violation_logit():
    return models(transform_search=violation_args, estimator_search = logit_search)

def violation_forest():
    return models(transform_search=violation_args, estimator_search = forest_search)

def violation_svm():
    return models(transform_search=violation_args, estimator_search = svm_search[0]) + \
           models(transform_search=violation_args, estimator_search = svm_search[1])

def violation_all():
    return violation_logit() + violation_forest() + violation_svm() + violation_train_years() + violation_region()

def evaluation():
    return models(transform_search=dict(train_years=4, **evaluation_args), estimator_search=forest)

def calibrated_evaluation():
    return calibrated_models(transform_search={'outcome':['evaluation_epa'], 'train_years':[4], 'year':[2012],
    }, estimator_search = forest)

def evaluation_and_violation():
    return evaluation_and_violation_models(evaluation(), violation_best())

def evaluation_and_violation_region_4():
    return evaluation_and_violation_models(evaluation(), violation_region_4())

def evaluation_and_violation_models(es, vs):
    evs = []
    for e in es:
        e_year = e.inputs[1].year
        e.get_input('transform').__name__ = 'e_transform'
        e.get_input('estimator').__name__ = 'e_estimator'
        e.get_input('y').__name__ = 'e_y'
        for v in vs:
            v_year = v.inputs[1].year
            if e_year == v_year:
                ev = model.PredictProduct(inputs= [e,v], 
                    inputs_mapping=['evaluation', 'violation'], 
                    target=True)
                evs.append(ev)
    return evs

def calibrated_violation():
    return calibrated_models(transform_search= {'outcome':['violation_epa'], 'year':[2012], 'train_years': [2],
            }, estimator_search=forest)

def calibrated_evaluation_and_violation():
    e = calibrated_evaluation()[0]
    v = calibrated_violation()[0]
    ve = model.PredictProduct(inputs= [e,v], inputs_mapping=['inspection', 'violation'], target=True)
    ve.get_input('transform').__name__ = 'transform2'
    ve.get_input('estimator').__name__ = 'estimator2'
    ve.get_input('y').__name__ = 'y2'
    return [ve]


def evaluation_best():
    return models(transform_search=evaluation_args, estimator_search=forest) + \
            models(transform_search=evaluation_args, estimator_search=svm) + \
            models(transform_search=evaluation_args, estimator_search=logit)

def models(transform_search={}, estimator_search={}):
    steps = []
    transform_search = util.merge_dicts(dict(
        train_years = [3],
        year=range(2011,2015+1)
    ), transform_search)

    for transform_args, estimator_args in product(
            util.dict_product(transform_search), 
            util.dict_product(estimator_search)):
        logging.info('%s, %s' % (transform_args, estimator_args))

        transform = EpaTransform(month=1, day=1, name='transform', **transform_args)

        estimator = step.Construct(name='estimator', **estimator_args)

        y = model.FitPredict(inputs=[estimator, transform], name='y', target=True)
        steps.append(y)

    return steps


def calibrated_models(transform_search={}, estimator_search={}):
    steps = []
    transform_search = util.merge_dicts(dict(
        train_years = [3],
        year=range(2012,2015+1)
    ), transform_search)

    for transform_args, estimator_args in product(
            util.dict_product(transform_search), 
            util.dict_product(estimator_search)):
        logging.info('%s, %s' % (transform_args, estimator_args))

        transform = EpaTransform(month=1, day=1, name='transform', **transform_args)
        
        estimator = step.Construct(name='estimator', **estimator_args)
        calibrator =  step.Construct('sklearn.calibration.CalibratedClassifierCV', cv=10,
                inputs=[estimator], inputs_mapping=['base_estimator'], name='calibrator')

        y = model.FitPredict(inputs=[calibrator, transform], name='y', target=True)
        steps.append(y)

    return steps
